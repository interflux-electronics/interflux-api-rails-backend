require 'yaml'
require 'byebug'
require 'ap'

count_before = SolderingProcess.count

puts '---------'
puts 'Seeding soldering processes'
puts '---------'

file = File.read 'db/seeds/data/soldering_processes.yml'
data = YAML.safe_load(file)

data.each_with_index do |_process, i|
  process = OpenStruct.new(_process)

  puts "#{i + 1} - #{process.name}"

  process_record = SolderingProcess.find_by(slug: process.slug)

  process_properties = OpenStruct.new(
    slug: process.slug,
    name: process.name
  )

  if process_record.nil?
    process_record = SolderingProcess.create!(process_properties.to_h)
  else
    process_record.update!(process_properties.to_h)
  end
end

puts '---------'
count_after = SolderingProcess.count
difference = count_after - count_before
puts "Before seeding, the database had #{count_before} processs."
puts "After seeding, the database has #{count_after}."
puts "That's #{difference} new ones."
puts '---------'
puts 'Success!'
puts '---------'
puts ' '
