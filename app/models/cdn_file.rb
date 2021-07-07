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
    puts 'create_image_or_document'
    create_image if image?
    create_document if document?
  end

  def destroy_image_or_document
    puts 'destroy_image_or_document'
    destroy_image if image?
    destroy_document if document?
  end

  # IMAGES

  def image?
    [
      'images/products/',
      'images/processes/',
      'images/logos/',
      'images/icons/'
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
