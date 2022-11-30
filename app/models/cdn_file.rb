class CdnFile < ApplicationRecord
  validates :path, uniqueness: true, allow_blank: true

  belongs_to :user, optional: true
  belongs_to :image, optional: true
  belongs_to :video, optional: true
  belongs_to :document, optional: true

  scope :fonts, -> { where 'path LIKE :prefix', prefix: 'fonts/%' }
  scope :images, -> { where 'path LIKE :prefix', prefix: 'images/%' }
  scope :videos, -> { where 'path LIKE :prefix', prefix: 'videos/%' }
  scope :webinars, -> { where 'path LIKE :prefix', prefix: 'videos/webinars%' }
  scope :documents, -> { where 'path LIKE :prefix', prefix: 'documents/%' }

  after_create :create_owner, :update_document_variation
  after_update :update_document_variation
  before_destroy :destroy_owner, :delete_cdn_file
  after_destroy :update_document_variation

  private

  def create_owner
    return if path.blank?

    puts 'create_owner'
    create_image if image?
    create_video if video?
  end

  def destroy_owner
    return if path.blank?

    puts 'destroy_owner'
    destroy_image if image?
    destroy_video if video?
  end

  # CDN FILES

  def delete_cdn_file
    puts '------'
    puts 'deleting from CDN...'

    do_s3_client.delete_object(
      {
        bucket: ENV['DO_BUCKET'],
        key: path
      }
    )

    puts 'delete complete'
    puts '------'
  end

  def do_s3_client
    Aws::S3::Client.new(
      access_key_id: ENV['DO_ACCESS'],
      secret_access_key: ENV['DO_SECRET'],
      endpoint: ENV['DO_ENDPOINT'],
      force_path_style: false,
      region: ENV['DO_REGION']
    )
  end

  # IMAGES

  def image?
    [
      'images/products/',
      'images/processes/',
      'images/logos/',
      'images/icons/',
      'images/people/'
    ].any? { |p| path.start_with?(p) }
  end

  # Find the shared path for images. The below example should result in only 2 image records
  # being created, the first one with 2 variations, the latter with 4 variations.
  # logo.svg
  # logo.png
  # photo@800x800.jpg
  # photo@800x800.webp
  # photo@1200x1200.jpg
  # photo@1200x1200.webp
  def base_image_path
    path.include?('@') ? path.split('@').first : path.split('.').first
  end

  def create_image
    puts 'create_image'

    cdn_files = CdnFile.all

    # TODO: filter out @original?

    subset = cdn_files.filter { |x| x.path.start_with?("#{base_image_path}@") } if path.include? '@'
    subset = cdn_files.filter { |x| x.path.start_with?("#{base_image_path}.") } if path.exclude? '@'

    variations = subset.map { |x| "@#{x.path.split('@').last}" }.sort_by { |x| x.split('x').first.to_i }.join(',') if path.include? '@'
    variations = subset.map { |x| ".#{x.path.split('.').last}" }.join(',') if path.exclude? '@'

    props = OpenStruct.new(
      path: base_image_path,
      alt: base_image_path.split('/').last.gsub('-', ' '),
      variations: variations
    )

    image = Image.find_by(path: base_image_path)

    if image.present?
      image.update!(props.to_h)
      puts 'UPDATED image record'
    else
      image = Image.create!(props.to_h)
      puts 'CREATED image record'
    end

    subset.each do |cdn_file|
      cdn_file.image_id = image.id
      cdn_file.save!
    end
  end

  def destroy_image
    puts 'destroy_image'

    extension = path.include?('@') ? "@#{path.split('@').last}" : ".#{path.split('.').last}"
    image = Image.find(base_image_path)

    puts "shared path: #{base_image_path}"
    puts "extension: #{extension}"

    # Remove this one extension from the variations
    v = image.variations.split(',').reject { |x| x == extension }.join(',')

    puts "variations before: #{image.variations}"
    puts "variations after: #{v}"

    # If at least one variation remains, then keep the record, remove extension from variations
    if v.present?
      image.update(variations: v)
      puts 'updated image'
    end

    # If no variations are left, destroy the record
    if v.blank?
      if image.present?
        image.destroy
        puts 'destroyed image'
      else
        puts 'no image found'
      end
    end
  end

  # VIDEOS

  def video?
    [
      'videos/webinars/'
    ].any? { |p| path.start_with?(p) }
  end

  # Find the shared path for images. The below example should result in only 2 image records
  # being created, the first one with 2 variations, the latter with 4 variations.
  # logo.svg
  # logo.png
  # photo@800x800.jpg
  # photo@800x800.webp
  # photo@1200x1200.jpg
  # photo@1200x1200.webp
  def base_video_path
    path.include?('@') ? path.split('@').first : path.split('.').first
  end

  def create_video
    puts 'create_video'

    cdn_files = CdnFile.all

    subset = cdn_files.filter { |x| x.path.start_with?("#{base_video_path}@") } if path.include? '@'
    subset = cdn_files.filter { |x| x.path.start_with?("#{base_video_path}.") } if path.exclude? '@'

    variations = subset.map { |x| "@#{x.path.split('@').last}" }.sort_by { |x| x.split('x').first.to_i }.join(',') if path.include? '@'
    variations = subset.map { |x| ".#{x.path.split('.').last}" }.join(',') if path.exclude? '@'

    title = base_video_path.split('/').last.gsub('-', ' ')

    props = OpenStruct.new(
      path: base_video_path,
      title_admin: title,
      title_public: title,
      variations: variations,
      poster_url: nil
    )

    video = Video.find_by(path: base_video_path)

    if video.present?
      video.update!(props.to_h)
      puts 'UPDATED video record'
    else
      video = Video.create!(props.to_h)
      puts 'CREATED video record'
    end

    subset.each do |cdn_file|
      cdn_file.video_id = video.id
      cdn_file.save!
    end
  end

  def destroy_video
    puts 'destroy_video'

    extension = path.include?('@') ? "@#{path.split('@').last}" : ".#{path.split('.').last}"
    video = Video.find(base_video_path)

    puts "shared path: #{base_video_path}"
    puts "extension: #{extension}"

    # Remove this one extension from the variations
    v = video.variations.split(',').reject { |x| x == extension }.join(',')

    puts "variations before: #{video.variations}"
    puts "variations after: #{v}"

    # If at least one variation remains, then keep the record, remove extension from variations
    if v.present?
      video.update(variations: v)
      puts 'updated video'
    end

    # If no variations are left, destroy the record
    if v.blank?
      video.destroy
      puts 'destroyed video'
    end
  end

  # DOCUMENTS

  def update_document_variation
    return if document.nil?

    puts '------'
    v = document.files.map { |f| f.path.split('-').last }.join(',')
    document.update(variations: v)
    puts "updated document variations to #{v}"
    puts '------'
  end
end
