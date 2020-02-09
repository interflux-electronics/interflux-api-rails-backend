require 'byebug'
require 'ap'

puts '---------'
puts 'Seeding images'
puts '---------'

# The source of truth for images is the CDN, not the database. Therefor we
# always delete images before seeding. Note that this will break all relations
# to these images.
Image.delete_all

before = Image.count

file = File.read 'db/seeds/images.yml'
list = YAML.safe_load(file)

list.each_with_index do |image, i|
  image = OpenStruct.new(image)

  puts "#{i + 1} - #{image.cdn_path}"

  props = OpenStruct.new(
    cdn_path: image.cdn_path,
    sizes: '2400x2400,2200x2200,2000x2000,1800x1800,1600x1600,1400x1400,1200x1200,1000x1000,800x800,600x600,400x400,200x200,100x100,50x50',
    formats: 'jpg,webp'
  )

  # Some images will not be square, allow overwrite if specified in YML file
  props.sizes = image.sizes if image.sizes.present?

  # In case there are SVGs
  props.formats = image.formats if image.formats.present?

  record = Image.find_by(cdn_path: image.cdn_path)

  if record.nil?
    Image.create!(props.to_h)
  else
    record.update!(props.to_h)
  end
end

puts '---------'
after = Image.count
difference = after - before
puts "Before seeding, the database had #{before} images."
puts "After seeding, the database has #{after}."
puts "That's #{difference} new ones."
puts '---------'
puts 'Success!'
puts '---------'
puts ' '
