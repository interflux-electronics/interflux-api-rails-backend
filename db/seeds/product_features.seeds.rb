after :products, :features do
  count_before = ProductFeature.count

  puts '---------'
  puts 'Seeding product features'
  puts '---------'

  file = File.read 'db/seeds/data/products.yml'
  data = YAML.safe_load(file)

  data.each_with_index do |_product, i|
    product = OpenStruct.new(_product)
    counter = i + 1
    spaces = ' ' * counter.to_s.length

    puts "#{counter} - #{product.name}"

    product_record = Product.find(product.slug)
    byebug if product_record.nil?

    if product.qualities
      puts "#{spaces}   Qualities:"
      product.qualities.each do |quality|
        puts "#{spaces}   - #{quality}"

        feature = OpenStruct.new
        feature.slug = quality
        feature.category = 'quality'

        feature_record = Feature.where(category: feature.category).find(feature.slug)

        byebug if feature_record.nil?
      end
    end

    if product.processes
      puts "#{spaces}   Processes:"
      product.processes.each do |process|
        puts "#{spaces}   - #{process}"

        feature = OpenStruct.new
        feature.slug = process
        feature.category = 'process'

        feature_record = Feature.where(category: feature.category).find(feature.slug)

        byebug if feature_record.nil?
      end
    end

    # feature_record = Feature.find_by(slug: product.slug)
    # byebug if feature_record.nil?
    #
    #   product_record = Product.find_by(name: product_name)
    #   byebug if product_record.nil?
    #
    #   relation_record = ProductFeature.where(product_id: product_record.id).where(feature_id: feature_record.id).first
    #
    #   properties = OpenStruct.new(
    #     product_id: product_record.id,
    #     feature_id: feature_record.id
    #   )
    #
    #   if relation_record.nil?
    #     ProductFeature.create!(properties.to_h)
    #   else
    #     relation_record.update!(properties.to_h)
    #   end
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
