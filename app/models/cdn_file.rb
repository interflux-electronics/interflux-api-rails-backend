class CdnFile < ApplicationRecord
  belongs_to :image, optional: true
  belongs_to :document, optional: true

  validates :path, presence: true, uniqueness: true

  scope :fonts, -> { where 'path LIKE :prefix', prefix: 'fonts/%' }
  scope :images, -> { where 'path LIKE :prefix', prefix: 'images/%' }
  scope :documents, -> { where 'path LIKE :prefix', prefix: 'documents/%' }

  after_create

  # To make full name searches possible we update the full name column after every save
  after_create :create_image_or_document
  before_destroy :destroy_image_or_document

  private

  def create_image_or_document
    puts 'create image or document'
    create_image if image?
    create_document if document?
  end

  def destroy_image_or_document
    puts 'destroy image or document'
    destroy_image if image?
    destroy_document if document?
  end

  def image?
    [
      'images/products/',
      'images/processes/',
      'images/logos/',
      'images/icons/'
    ].any? { |p| path.start_with?(p) }
  end

  def document?
    path.starts_with?('documents/')
  end

  def create_document
    puts 'create image record'
  end

  # Find the shared path for images. The below example should result in only 2 image records
  # being created with a range of size and type variaties.
  # logo.svg
  # logo.png
  # photo@800x800.jpg
  # photo@800x800.webp
  # photo@1200x1200.jpg
  # photo@1200x1200.webp
  def shared_path
    path.include?('@') ? path.split('@').first : path.split('.').first
  end

  def create_image
    puts 'create image record'

    cdn_files = CdnFile.all

    subset = cdn_files.filter { |x| x.path.start_with?("#{shared_path}@") } if path.include? '@'
    subset = cdn_files.filter { |x| x.path.start_with?("#{shared_path}.") } if path.exclude? '@'

    variations = subset.map { |x| "@#{x.path.split('@').last}" }.sort_by { |x| x.split('x').first.to_i }.join(',') if path.include? '@'
    variations = subset.map { |x| ".#{x.path.split('.').last}" }.join(',') if path.exclude? '@'

    props = OpenStruct.new(
      path: shared_path,
      alt: shared_path.split('/').last.gsub('-', ' '),
      variations: variations
    )

    image = Image.find_by(path: shared_path)

    if image.present?
      puts 'UPDATED image record'
      image.update!(props.to_h)
    else
      puts 'CREATED image record'
      image = Image.create!(props.to_h)
    end

    subset.each do |cdn_file|
      cdn_file.image_id = image.id
      cdn_file.save!
    end
  end

  def destroy_image
    puts 'destroy_image'

    shared_path = path.include?('@') ? path.split('@').first : path.split('.').first
    extension = path.include?('@') ? "@#{path.split('@').last}" : ".#{path.split('.').last}"
    image = Image.find(shared_path)

    puts "shared path: #{shared_path}"
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
end
