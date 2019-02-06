after :countries, :currencies do
  require 'json'
  require 'byebug'
  require 'ap'

  count_before = CountryCurrency.count

  puts '---------'
  puts 'Seeding country currencies'
  puts '---------'
  puts 'Deleting all existing relationships'
  CountryCurrency.delete_all
  puts '---------'

  file = File.read 'db/seeds/data/countries.json'
  data = JSON.parse(file)

  data.each_with_index do |hash, i|
    country = OpenStruct.new(hash)
    country.currencies.each do |curr|
      currency = OpenStruct.new(curr)

      puts "#{i} - Relating #{currency.name} to #{country.name}"

      if currency.code.nil? || currency.code == '(none)'
        puts '//////'
        puts 'WARNING: No currency code'
        puts currency.to_json
        puts '//////'
      else
        country_record = Country.find_by(iso_3161_1_alpha_2_code: country.alpha_2_code)
        currency_record = Currency.find_by(code: currency.code)

        byebug if country_record.nil?
        byebug if currency_record.nil?

        properties = OpenStruct.new(
          country_id: country_record.id,
          currency_id: currency_record.id
        )

        CountryCurrency.create(properties.to_h)
      end
    end
  end

  puts '---------'
  count_after = CountryCurrency.count
  difference = count_after - count_before
  puts "Before seeding, the database had #{count_before} country currencies."
  puts "After seeding, the database has #{count_after}."
  puts "That's #{difference} new ones."
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
