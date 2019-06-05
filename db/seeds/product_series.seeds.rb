require 'yaml'
require 'byebug'
require 'ap'

after :product_families do  
  count_before = ProductSerie.count

  puts '---------'
  puts 'Seeding product series'
  puts '---------'

  file = File.read 'db/seeds/data/product_series.yml'
  data = YAML.safe_load(file)

  data.each_with_index do |_serie, i|
    serie = OpenStruct.new(_serie)

    puts "#{i + 1} - #{serie.name}"

    family = ProductFamily.find_by(name_plural: serie.family)

    byebug if family.nil?

    properties = OpenStruct.new(
      slug: serie.slug,
      code: serie.code,
      name: serie.name,
      public: serie.public,
      continued: serie.continued,
      product_family_id: family.id
    )

    record = ProductSerie.find_by(slug: serie.slug)

    if record.nil?
      ProductSerie.create!(properties.to_h)
    else
      record.update!(properties.to_h)
    end
  end

  puts '---------'
  count_after = ProductSerie.count
  difference = count_after - count_before
  puts "Before seeding, the database had #{count_before} product series."
  puts "After seeding, the database has #{count_after}."
  puts "That's #{difference} new ones."
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
