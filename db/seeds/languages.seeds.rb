require 'json'
require 'byebug'
require 'ap'

count_before = Language.count

puts '---------'
puts 'Seeding languages'
puts '---------'

file = File.read 'db/seeds/data/countries.json'
data = JSON.parse(file)

data.each_with_index do |hash, i|
  country = OpenStruct.new(hash)
  country.languages.each do |lang|
    language = OpenStruct.new(lang)
    puts "#{i} - Seeding #{language.name} (#{country.name})"
    record = Language.find_by(iso_639_1_code: language.iso639_1)
    properties = OpenStruct.new(
      name_english: language.name,
      name_native: language.native_name,
      iso_639_1_code: language.iso639_1,
      iso_639_2_code: language.iso639_2
    )
    if record.nil?
      Language.create(properties.to_h)
    else
      record.update(properties.to_h)
    end
  end
end

puts '---------'
count_after = Language.count
difference = count_after - count_before
puts "Before seeding, the database had #{count_before} country currencies."
puts "After seeding, the database has #{count_after}."
puts "That's #{difference} new ones."
puts '---------'
puts 'Success!'
puts '---------'
puts ' '
