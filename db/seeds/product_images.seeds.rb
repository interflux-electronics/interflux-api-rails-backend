require 'byebug'
require 'ap'

after :products do
  image_count_before = Image.count
  relation_count_before = ProductImage.count

  puts '---------'
  puts 'Seeding product images'
  puts '---------'

  file = File.read 'db/seeds/product_images.yml'
  data = YAML.safe_load(file)

  data.each_with_index do |_data, i|
    _image = OpenStruct.new(_data)

    puts "#{i + 1} - #{_image.cdn_path}"

    properties = OpenStruct.new(
      cdn_path: _image.cdn_path,
      sizes: '2400x2400,2200x2200,2000x2000,1800x1800,1600x1600,1400x1400,1200x1200,1000x1000,800x800,600x600,400x400,200x200,100x100,50x50',
      formats: 'jpg,webp'
    )

    # Some images will not be square, allow overwrite if specified in YML file
    if _image.sizes.present?
      properties.sizes = _image.sizes
    end

    image = Image.find_by(cdn_path: _image.cdn_path)

    if image.nil?
      image = Image.create!(properties.to_h)
    else
      image.update!(properties.to_h)
    end

    # /images/products/IF-2005M/IF-2005M-10L-front
    slug = _image.cdn_path.split('/')[3]
    product = Product.find_by(slug: slug)

    if product.nil?
      puts "     TODO: No product found for slug: #{slug}"
      puts ""
      next
    end

    relation = ProductImage.where(image_id: image.id, product_id: product.id).first

    properties = OpenStruct.new(
      product_id: product.id,
      image_id: image.id,
    )

    if relation.nil?
      ProductImage.create!(properties.to_h)
    else
      relation.update!(properties.to_h)
    end
  end

  puts '---------'
  count_after = Image.count
  difference = count_after - image_count_before
  puts "Before seeding, the database had #{image_count_before} images."
  puts "After seeding, the database has #{count_after}."
  puts "That's #{difference} new ones."
  puts '---------'
  count_after = ProductImage.count
  difference = count_after - relation_count_before
  puts "Before seeding, the database had #{relation_count_before} product images."
  puts "After seeding, the database has #{count_after}."
  puts "That's #{difference} new ones."
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
