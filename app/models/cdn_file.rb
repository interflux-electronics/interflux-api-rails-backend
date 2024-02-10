# == Schema Information
#
# Table name: cdn_files
#
#  id                 :uuid             not null, primary key
#  locale             :string
#  original_file_name :string
#  path               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  document_id        :string
#  image_id           :string
#  user_id            :uuid
#  video_id           :string
#
# Indexes
#
#  index_cdn_files_on_path  (path)
#
class CdnFile < ApplicationRecord
  validates :path, uniqueness: true, allow_blank: true

  # Who uploaded the file.
  belongs_to :user, optional: true

  # Images have many sizes and file types.
  # Image records link back to many CdnFile.
  # Each CdnFile represents 1 of the many size and file types.
  belongs_to :image, optional: true

  # Same as image, read above.
  belongs_to :video, optional: true

  # Documents are always PDFs and can have many translations.
  # Each CdnFile represents 1 of the many translations.
  belongs_to :document, optional: true

  # Shorthands
  scope :fonts, -> { where 'path LIKE :prefix', prefix: 'fonts/%' }
  scope :images, -> { where 'path LIKE :prefix', prefix: 'images/%' }
  scope :product_images, -> { where 'path LIKE :prefix', prefix: 'images/products/%' }
  scope :videos, -> { where 'path LIKE :prefix', prefix: 'videos/%' }
  scope :webinars, -> { where 'path LIKE :prefix', prefix: 'videos/webinars%' }
  scope :documents, -> { where 'path LIKE :prefix', prefix: 'documents/%' }

  # Life cycle hooks
  after_create :sync_owner_variations
  after_update :sync_owner_variations
  before_destroy :delete_cdn_file
  after_destroy :sync_owner_variations

  private

  # The owner can be an Image, Video or Document record.
  def owner
    # return image if image.present?
    # return video if video.present?
    return document if document.present?

    nil
  end

  # Each time a CdnFile is created, updated or destroyed, we need to resync the variations stored on the owner.
  # Variations are a concatenated string of all CdnFile.path endings.
  # We cache that string on the owner so that we don't have to sideload all related CdnFile.
  def sync_owner_variations
    return if owner.nil?

    owner.sync_variations
  end

  def delete_cdn_file
    CdnService.new.delete(path)
  end

  # IMAGES

  # def image?
  #   [
  #     'images/products/',
  #     'images/processes/',
  #     'images/logos/',
  #     'images/icons/',
  #     'images/people/'
  #   ].any? { |p| path.start_with?(p) }
  # end

  # Find the shared path for images. The below example should result in only 2 image records
  # being created, the first one with 2 variations, the latter with 4 variations.
  # logo.svg
  # logo.png
  # photo@800x800.jpg
  # photo@800x800.webp
  # photo@1200x1200.jpg
  # photo@1200x1200.webp
  # def base_image_path
  #   path.include?('@') ? path.split('@').first : path.split('.').first
  # end

  # def create_image
  #   puts 'create_image'

  #   cdn_files = CdnFile.all

  #   # TODO: filter out @original?

  #   subset = cdn_files.filter { |x| x.path.start_with?("#{base_image_path}@") } if path.include? '@'
  #   subset = cdn_files.filter { |x| x.path.start_with?("#{base_image_path}.") } if path.exclude? '@'

  #   variations = subset.map { |x| "@#{x.path.split('@').last}" }.sort_by { |x| x.split('x').first.to_i }.join(',') if path.include? '@'
  #   variations = subset.map { |x| ".#{x.path.split('.').last}" }.join(',') if path.exclude? '@'

  #   props = OpenStruct.new(
  #     path: base_image_path,
  #     alt: base_image_path.split('/').last.gsub('-', ' '),
  #     variations: variations
  #   )

  #   image = Image.find_by(path: base_image_path)

  #   if image.present?
  #     image.update!(props.to_h)
  #     puts 'UPDATED image record'
  #   else
  #     image = Image.create!(props.to_h)
  #     puts 'CREATED image record'
  #   end

  #   subset.each do |cdn_file|
  #     cdn_file.image_id = image.id
  #     cdn_file.save!
  #   end
  # end

  # def destroy_image
  #   puts 'destroy_image'

  #   extension = path.include?('@') ? "@#{path.split('@').last}" : ".#{path.split('.').last}"
  #   image = Image.find(base_image_path)

  #   puts "shared path: #{base_image_path}"
  #   puts "extension: #{extension}"

  #   # Remove this one extension from the variations
  #   v = image.variations.split(',').reject { |x| x == extension }.join(',')

  #   puts "variations before: #{image.variations}"
  #   puts "variations after: #{v}"

  #   # If at least one variation remains, then keep the record, remove extension from variations
  #   if v.present?
  #     image.update(variations: v)
  #     puts 'updated image'
  #   end

  #   # If no variations are left, destroy the record
  #   if v.blank?
  #     if image.present?
  #       image.destroy
  #       puts 'destroyed image'
  #     else
  #       puts 'no image found'
  #     end
  #   end
  # end

  # VIDEOS

  # def video?
  #   [
  #     'videos/webinars/'
  #   ].any? { |p| path.start_with?(p) }
  # end

  # Find the shared path for images. The below example should result in only 2 image records
  # being created, the first one with 2 variations, the latter with 4 variations.
  # logo.svg
  # logo.png
  # photo@800x800.jpg
  # photo@800x800.webp
  # photo@1200x1200.jpg
  # photo@1200x1200.webp
  # def base_video_path
  #   path.include?('@') ? path.split('@').first : path.split('.').first
  # end

  # def create_video
  #   puts 'create_video'

  #   cdn_files = CdnFile.all

  #   subset = cdn_files.filter { |x| x.path.start_with?("#{base_video_path}@") } if path.include? '@'
  #   subset = cdn_files.filter { |x| x.path.start_with?("#{base_video_path}.") } if path.exclude? '@'

  #   variations = subset.map { |x| "@#{x.path.split('@').last}" }.sort_by { |x| x.split('x').first.to_i }.join(',') if path.include? '@'
  #   variations = subset.map { |x| ".#{x.path.split('.').last}" }.join(',') if path.exclude? '@'

  #   title = base_video_path.split('/').last.gsub('-', ' ')

  #   props = OpenStruct.new(
  #     path: base_video_path,
  #     title_admin: title,
  #     title_public: title,
  #     variations: variations,
  #     poster_url: nil
  #   )

  #   video = Video.find_by(path: base_video_path)

  #   if video.present?
  #     video.update!(props.to_h)
  #     puts 'UPDATED video record'
  #   else
  #     video = Video.create!(props.to_h)
  #     puts 'CREATED video record'
  #   end

  #   subset.each do |cdn_file|
  #     cdn_file.video_id = video.id
  #     cdn_file.save!
  #   end
  # end

  # def destroy_video
  #   puts 'destroy_video'

  #   extension = path.include?('@') ? "@#{path.split('@').last}" : ".#{path.split('.').last}"
  #   video = Video.find(base_video_path)

  #   puts "shared path: #{base_video_path}"
  #   puts "extension: #{extension}"

  #   # Remove this one extension from the variations
  #   v = video.variations.split(',').reject { |x| x == extension }.join(',')

  #   puts "variations before: #{video.variations}"
  #   puts "variations after: #{v}"

  #   # If at least one variation remains, then keep the record, remove extension from variations
  #   if v.present?
  #     video.update(variations: v)
  #     puts 'updated video'
  #   end

  #   # If no variations are left, destroy the record
  #   if v.blank?
  #     video.destroy
  #     puts 'destroyed video'
  #   end
  # end

  # DOCUMENTS
end
