require 'yaml'
require 'byebug'
require 'ap'

after :product_families do
  count_before = Product.count

  puts '---------'
  puts 'Seeding products'
  puts '---------'

  file = File.read 'db/seeds/data/products.yml'
  data = YAML.safe_load(file)

  data.each_with_index do |_product, i|
    product = OpenStruct.new(_product)

    puts "#{i + 1} - #{product.name}"

    family = ProductFamily.find_by(name_plural: product.family)

    byebug if family.nil?

    properties = OpenStruct.new(
      slug: product.slug,
      code: product.code,
      name: product.name,

      public: product.public,
      deprecated: product.deprecated || false,
      orderable: product.orderable || true,
      popular: product.popular || false,
      new: product.new || false,

      product_family_id: family.id
    )

    record = Product.find_by(slug: product.slug)

    if record.nil?
      Product.create!(properties.to_h)
    else
      record.update!(properties.to_h)
    end
  end

  puts '---------'
  count_after = Product.count
  difference = count_after - count_before
  puts "Before seeding, the database had #{count_before} products."
  puts "After seeding, the database has #{count_after}."
  puts "That's #{difference} new ones."
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
