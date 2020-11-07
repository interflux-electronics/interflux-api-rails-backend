require 'yaml'
require 'byebug'
require 'ap'

count_before = Use.count

puts '---------'
puts 'Seeding uses'
puts '---------'

file = File.read 'db/seeds/data/uses.yml'
data = YAML.safe_load(file)

data.each_with_index do |_use, i|
  use = OpenStruct.new(_use)

  puts "#{i + 1} - #{use.name}"

  use_record = Use.find_by(slug: use.slug)

  use_properties = OpenStruct.new(
    slug: use.slug,
    name: use.name
  )

  if use_record.nil?
    use_record = Use.create!(use_properties.to_h)
  else
    use_record.update!(use_properties.to_h)
  end
end

puts '---------'
count_after = Use.count
difference = count_after - count_before
puts "Before seeding, the database had #{count_before} uses."
puts "After seeding, the database has #{count_after}."
puts "That's #{difference} new ones."
puts '---------'
puts 'Success!'
puts '---------'
puts ' '
