#
# Table name: cdn_files
#
#  id          :uuid             not null, primary key
#  path        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image_id    :string
#  document_id :string
#

class CdnFile < ApplicationRecord
  belongs_to :image, optional: true
  belongs_to :document, optional: true

  validates :path, presence: true, uniqueness: true

  scope :fonts, -> { where "path LIKE :prefix", prefix: "fonts/%" }
  scope :images, -> { where "path LIKE :prefix", prefix: "images/%" }
  scope :documents, -> { where "path LIKE :prefix", prefix: "documents/%" }

  after_create

  # To make full name searches possible we update the full name column after every save
  after_create :create_parent_record

  private

  def create_parent_record
    puts "creating parent record for: #{path}"

    is_valid_image_path = [
      'images/products/',
      'images/processes/',
      'images/logos/',
      'images/icons/'
    ].any? { |x| path.start_with?(x) }

    if is_valid_image_path
      puts 'is image path'

      # Fetch all CDN file records from database
      cdn_files = CdnFile.all

      # Find the shared path for images. The below example should result in only 2 image records
      # being created with a range of size and type variaties.
      # logo.svg
      # logo.png
      # photo@800x800.jpg
      # photo@800x800.webp
      # photo@1200x1200.jpg
      # photo@1200x1200.webp
      shared_path = if path.include? '@' then path.split('@').first else path.split('.').first end

      subset = cdn_files.filter { |x| x.path.start_with?("#{shared_path}@") } if path.include? '@'
      subset = cdn_files.filter { |x| x.path.start_with?("#{shared_path}.") } if path.exclude? '@'

      variations = subset.map { |x| "@#{x.path.split('@').last}" } .sort_by { |x| x.split('x').first.to_i } .join(',') if path.include? '@'
      variations = subset.map { |x| ".#{x.path.split('.').last}" } .join(',') if path.exclude? '@'

      props = OpenStruct.new(
        path: shared_path,
        alt: shared_path.split('/').last.gsub('-', ' '),
        variations: variations
      )

      image = Image.find_by(path: shared_path)

      if image.present?
        puts "UPDATED image record"
        image.update!(props.to_h)
      else
        puts "CREATED image record"
        image = Image.create!(props.to_h)
      end

      subset.each do |cdn_file|
        cdn_file.image_id = image.id
        cdn_file.save!
      end
    end

    if path.starts_with? 'documents/'
      puts 'is document path'
    end
  end
end
