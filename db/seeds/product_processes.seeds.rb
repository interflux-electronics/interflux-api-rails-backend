require 'yaml'
require 'byebug'
require 'ap'

after :product_series, :soldering_processes do

  count_before = ProductProcess.count

  puts '---------'
  puts 'Seeding product processes'
  puts '---------'

  file = File.read 'db/seeds/data/soldering_processes.yml'
  data = YAML.safe_load(file)

  data.each_with_index do |_process, i|
    process = OpenStruct.new(_process)
    puts "#{i + 1} - #{process.name}"

    process.products.each_with_index do |product_name, ii|
      puts "#{i + 1}.#{ii + 1} - #{product_name}"

      process_record = SolderingProcess.find_by(name: process.name)
      product_record = ProductSerie.find_by(name: product_name)
      relation_record = ProductProcess.where(product_serie_id: product_record.id).where(soldering_process_id: process_record.id).first

      properties = OpenStruct.new(
        product_serie_id: product_record.id,
        soldering_process_id: process_record.id
      )

      if relation_record.nil?
        ProductProcess.create!(properties.to_h)
      else
        relation_record.update!(properties.to_h)
      end
    end
  end

  puts '---------'
  count_after = ProductProcess.count
  difference = count_after - count_before
  puts "Before seeding, the database had #{count_before} product processes."
  puts "After seeding, the database has #{count_after}."
  puts "That's #{difference} new ones."
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
