require 'yaml'
require 'byebug'
require 'ap'

before = ProductFamily.count

puts '---------'
puts 'Seeding product families'
puts '---------'

file = File.read 'db/seeds/product_families.yml'
data = YAML.safe_load(file)

data.each_with_index do |_family, i|
  family = OpenStruct.new(_family)

  puts "#{i + 1} - #{family.name_plural}"

  record = ProductFamily.find_by(slug: family.slug)

  props = OpenStruct.new(
    slug: family.slug,
    code: family.code,
    name_single: family.name_single,
    name_plural: family.name_plural
  )

  if record.nil?
    ProductFamily.create!(props.to_h)
  else
    record.update!(props.to_h)
  end
end

puts '---------'
after = ProductFamily.count
difference = after - before
puts "Before seeding, the database had #{before} product families."
puts "After seeding, the database has #{after}."
puts "That's #{difference} new ones."
puts '---------'
puts 'Success!'
puts '---------'
puts ' '
