require 'yaml'
require 'byebug'
require 'ap'

after :products, :features do
  count_before = ProductFeature.count

  puts '---------'
  puts 'Seeding product features'
  puts '---------'

  file = File.read 'db/seeds/data/features.yml'
  data = YAML.safe_load(file)

  data.each_with_index do |_feature, i|
    feature = OpenStruct.new(_feature)
    puts "#{i + 1} - #{feature.text}"

    if feature.products.present?
      feature.products.each_with_index do |product_name, ii|
        puts "#{i + 1}.#{ii + 1} - #{product_name}"

        feature_record = Feature.find_by(slug: feature.slug)
        byebug if feature_record.nil?

        product_record = Product.find_by(name: product_name)
        byebug if product_record.nil?

        relation_record = ProductFeature.where(product_id: product_record.id).where(feature_id: feature_record.id).first

        properties = OpenStruct.new(
          product_id: product_record.id,
          feature_id: feature_record.id
        )

        if relation_record.nil?
          ProductFeature.create!(properties.to_h)
        else
          relation_record.update!(properties.to_h)
        end
      end
    end
  end

  puts '---------'
  count_after = ProductFeature.count
  difference = count_after - count_before
  puts "Before seeding, the database had #{count_before} product feature."
  puts "After seeding, the database has #{count_after}."
  puts "That's #{difference} new ones."
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
