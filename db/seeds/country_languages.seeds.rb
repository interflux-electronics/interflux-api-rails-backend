after :countries, :languages do
  require 'json'
  require 'byebug'
  require 'ap'

  count_before = CountryLanguage.count

  puts '---------'
  puts 'Seeding country languages'
  puts '---------'
  puts 'Deleting all existing relationships'
  CountryLanguage.delete_all
  puts '---------'

  file = File.read 'db/seeds/data/countries.json'
  data = JSON.parse(file)

  data.each_with_index do |hash, i|
    country = OpenStruct.new(hash)
    country.languages.each do |lang|
      language = OpenStruct.new(lang)

      puts "#{i} - Relating #{language.name} to #{country.name}"

      if language.iso639_1.nil?
        puts '//////'
        puts 'WARNING: No language code'
        puts language.to_json
        puts '//////'
      else
        country_record = Country.find_by(two_letter_code: country.alpha_2_code)
        language_record = Language.find_by(two_letter_code: language.iso639_1)

        byebug if country_record.nil?
        byebug if language_record.nil?

        properties = OpenStruct.new(
          country_id: country_record.id,
          language_id: language_record.id
        )

        CountryLanguage.create!(properties.to_h)
      end
    end
  end

  puts '---------'
  count_after = CountryLanguage.count
  difference = count_after - count_before
  puts "Before seeding, the database had #{count_before} country languages."
  puts "After seeding, the database has #{count_after}."
  puts "That's #{difference} new ones."
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
