# The purpose of this service is to convert CDN images, often high-resolution PNGs,
# to many smaller sizes in WEBP and JPG format.
#
# Approach:
#
# 1. Exit if Image.original is missing.
# 2. Exit if Image.converting == true.

# 3. List all files on CDN which start with the Image.path.
# 4. Deduct which variants still need to be converted.
# 5. Deduct which variants need to be deleted (obsolete sizes).
# 6. Exit if there is nothing to convert nor delete.
# 7. Set Image.converting = true.
# 7. Download the original image from the CDN.
# 8. Convert to WEBPs and JPGs.
# 9. Upload new files to CDN.
# 10. Delete obsolete files from CDN.
# 11. Again list all on CDN.
# 12. Save output to Image.variations.
# 13. Set Image.converting = false.
# 14. Remove local images.
#
class ImageConversionService
  def initialize(image_record)
    @image = image_record
  end

  def run
    logger.info '------'
    logger.info 'Converting image'

    raise 'wrong class' unless @image.is_a? Image
    raise 'already in progress' if @image.converting
    raise 'missing original' if @image.original.nil?
    raise 'missing ratio' if @image.ratio.nil?
    raise 'wrong format' unless %w[png jpg].include? @image.original_ext

    path = @image.path
    file_name = @image.file_name
    ratio = @image.ratio
    original = @image.original
    original_width = @image.original_width

    logger.info path

    lock_image

    files = CdnService.new.list(path)
    existing = files.map { |file| "@#{file.split('@').last}" }

    raise 'original is not on CDN' unless existing.include? original

    formats = %w[webp jpg]
    widths = [2400, 2000, 1600, 1200, 800, 400, 200, 100].select { |w| w <= original_width }
    wish_list = []
    formats.each do |ext|
      widths.each do |width|
        # Gotcha: Rails has this akward way of rounding down by default instead of to nearest integer.
        # https://stackoverflow.com/questions/36917405/integer-division-with-rounding/36917571#36917571
        # It's important one of the 2 numbers, or both, are floats. In this case, ratio is a float.
        height = (width / ratio).round
        wish_list.push("@#{width}x#{height}.#{ext}")
      end
    end
    to_create = wish_list - existing
    to_delete = existing - wish_list - [original]

    logger.info '------'
    logger.info 'found on CDN:'
    existing.each { |file| logger.info file }
    logger.info '------'
    logger.info 'wishlist:'
    wish_list.each { |file| logger.info file }
    logger.info '------'
    logger.info 'to create:'
    to_create.each { |file| logger.info file }
    logger.info 'none' if to_create.empty?
    logger.info '------'
    logger.info 'to delete:'
    to_delete.each { |file| logger.info file }
    logger.info 'none' if to_delete.empty?

    if to_create.empty? && to_delete.empty?
      logger.info '------'
      logger.info 'nothing to do here'
      unlock_image
      logger.info '------'

      return :done
    end

    to_upload = []

    logger.info '------'
    logger.info 'downloading original ...'
    cdn_path_original = "#{path}#{original}"
    local_path_original = "cdn/#{file_name}#{original}"

    CdnService.new.download(
      from: cdn_path_original,
      to: local_path_original
    )

    logger.info "done #{local_path_original}"

    webps = to_create.select { |file| file.end_with? '.webp' }
    if webps.any?
      logger.info '------'
      logger.info 'converting to WEBP ...'

      webps.each do |webp|
        sizes = webp.gsub('@', '').gsub('.webp', '').split('x')
        width = sizes.first.to_i
        height = sizes.last.to_i
        target = "cdn/#{file_name}#{webp}"

        WebP.encode(local_path_original, target, quality: 90, resize_w: width, resize_h: height)

        to_upload.push(target)

        logger.info "done #{target}"
      end
    end

    jpgs = to_create.select { |file| file.end_with? '.jpg' }
    if jpgs.any?
      logger.info '------'
      logger.info 'converting to JPG ...'

      jpgs.each do |jpg|
        size = jpg.gsub('@', '').gsub('.jpg', '')
        target = "cdn/#{file_name}#{jpg}"

        `convert "#{local_path_original}" -resize #{size} -quality 90 -interlace JPEG "#{target}"`

        to_upload.push(target)

        logger.info "done #{target}"
      end
    end

    logger.info '------'
    logger.info 'uploading to CDN ...'

    to_upload.each do |local_path|
      variant = local_path.split('@').last
      cdn_path = "#{path}@#{variant}"

      CdnService.new.upload(
        from: local_path,
        to: cdn_path
      )

      File.delete(local_path) if File.exist?(local_path)

      logger.info "done #{cdn_path}"
    end

    logger.info '------'
    logger.info 'found on CDN:'
    files = CdnService.new.list(path)
    files.each { |file| logger.info file }

    logger.info '------'
    logger.info 'syncing Image.variations'
    variations = CdnService.new.list(path).map { |p| "@#{p.split('@').last}" }.sort.join(',')
    logger.info variations
    @image.update!(
      variations: variations,
      converting: false
    )

    logger.info '------'
    logger.info 'syncing Image.variations'
    variations = CdnService.new.list(path).map { |p| "@#{p.split('@').last}" }.sort.join(',')
    logger.info variations
    @image.update!(
      variations: variations,
      converting: false
    )

    logger.info '------'
    logger.info 'deleting original file'
    File.delete(local_path_original) if File.exist?(local_path_original)

    unlock_image

    logger.info '------'
    logger.info 'Conversion complete'
    logger.info '------'

    # TODO: delete obsolete remote files
    # TODO: notify Jan of success
  rescue StandardError => e
    # Best guide on raising exceptions
    # https://www.honeybadger.io/blog/a-beginner-s-guide-to-exceptions-in-ruby/#:~:text=Exceptions%20are%20Ruby's%20way%20of,program%20starts%20to%20shut%20down.

    logger.error "ImageConversionService – #{e.message}"
    logger.debug e.class.name
    logger.debug e.backtrace
    logger.info '------'

    @image.update!(
      conversion_error_log: "#{e.message} | #{e.class.name} | #{e.backtrace}"
    )

    # TODO: notify Jan of fail
  end

  private

  def lock_image
    logger.info '------'
    logger.info 'Lock image'
    @image.update!(converting: true)
  end

  def unlock_image
    logger.info '------'
    logger.info 'Unlock image'
    @image.update!(converting: false)
  end

  def logger
    Rails.logger
  end
end
