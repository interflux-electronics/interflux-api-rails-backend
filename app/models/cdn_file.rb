class CdnFile < ApplicationRecord
  belongs_to :image, optional: true
  belongs_to :video, optional: true
  belongs_to :document, optional: true

  validates :path, presence: true, uniqueness: true

  scope :fonts, -> { where 'path LIKE :prefix', prefix: 'fonts/%' }
  scope :images, -> { where 'path LIKE :prefix', prefix: 'images/%' }
  scope :videos, -> { where 'path LIKE :prefix', prefix: 'videos/%' }
  scope :webinars, -> { where 'path LIKE :prefix', prefix: 'videos/webinars%' }
  scope :documents, -> { where 'path LIKE :prefix', prefix: 'documents/%' }

  after_create :create_owner
  before_destroy :destroy_owner

  private

  def create_owner
    puts 'create_owner'
    create_image if image?
    create_video if video?
    create_document if document?
  end

  def destroy_owner
    puts 'destroy_owner'
    destroy_image if image?
    destroy_video if video?
    destroy_document if document?
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
      image.destroy
      puts 'destroyed image'
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

  def document?
    path.starts_with?('documents/')
  end

  # Find the shared path for documents. The below example should result in only 2 document records
  # being created, the first one with 1 variations, the latter with 3 variations.
  # foo.pdf
  # bar-EN.pdf
  # bar-DE.pdf
  # bar-FR.pdf
  def base_document_path
    path.gsub(/.pdf$/, '').gsub(/-EN$|-DE$|-FR$/, '')
  end

  def multilingual
    path.split(/.pdf$/).first.match?(/-EN$|-DE$|-FR$/)
  end

  def create_document
    puts 'create_document'

    cdn_files = CdnFile.all
    document = Document.find_by(path: base_document_path)
    subset = cdn_files.filter { |x| x.path.start_with?(base_document_path) }
    variations = multilingual ? subset.map { |x| x.path.split('-').last }.join(',') : '.pdf'

    props = OpenStruct.new(
      path: base_document_path,
      name: base_document_path.split('/').last.gsub('-', ' '),
      document_category_id: base_document_path.split('/').second,
      variations: variations,
      public: true
    )

    if document.present?
      document.update!(props.to_h)
      puts 'UPDATED document record'
    else
      document = Document.create!(props.to_h)
      puts 'CREATED document record'
    end

    subset.each do |cdn_file|
      cdn_file.document_id = document.id
      cdn_file.save!
    end
  end

  def destroy_document
    puts 'destroy_document'

    document = Document.find(base_document_path)
    extension = multilingual ? path.scan(/EN.pdf$|DE.pdf$|FR.pdf$/)[0] : '.pdf'
    v = document.variations.split(',').reject { |x| x == extension }.join(',')

    puts "variations before: #{document.variations}"
    puts "variations after: #{v}"

    # If at least one variation remains, then keep the record, remove extension from variations
    if v.present?
      document.update(variations: v)
      puts 'updated document'
    end

    # If no variations are left, destroy the record
    if v.blank?
      document.destroy
      puts 'destroyed document'
    end
  end
end
