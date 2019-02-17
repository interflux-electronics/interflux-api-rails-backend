require 'yaml'
require 'byebug'
require 'ap'

count_before = ProductFamily.count

puts '---------'
puts 'Seeding product families'
puts '---------'

file = File.read 'db/seeds/data/product_families.yml'
data = YAML.safe_load(file)

data.each_with_index do |_family, i|
  family = OpenStruct.new(_family)

  puts "#{i + 1} - #{family.name_plural}"

  record = ProductFamily.find_by(slug: family.slug)

  properties = OpenStruct.new(
    slug: family.slug,
    code: family.code,
    name_single: family.name_single,
    name_plural: family.name_plural
  )

  if record.nil?
    ProductFamily.create(properties.to_h)
  else
    record.update(properties.to_h)
  end
end

puts '---------'
count_after = ProductFamily.count
difference = count_after - count_before
puts "Before seeding, the database had #{count_before} product families."
puts "After seeding, the database has #{count_after}."
puts "That's #{difference} new ones."
puts '---------'
puts 'Success!'
puts '---------'
puts ' '
