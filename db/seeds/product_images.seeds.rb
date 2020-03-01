after :images, :products do
  puts '---------'
  puts 'Seeding product images'
  puts '---------'

  count_before = ProductImage.count

  Image.all.each do |image|
    next unless image.path.start_with?('images/products/')

    slug = image.path.split('/').third
    product = Product.find_by(slug: slug)

    byebug if product.nil?

    props = OpenStruct.new(
      product_id: product.id,
      image_id: image.id,
    )

    record = ProductImage.find_by(product_id: product.id, image_id: image.id)

    if record.nil?
      ProductImage.create!(props.to_h)
    else
      record.update!(props.to_h)
    end

    alt = "#{product.family.name_single} #{product.name}"
    suffix = image.path.split('/').last.split(product.slug).last
    suffix = suffix.gsub('-', ' ').strip if suffix.present?
    alt += " #{suffix}" if suffix.present?
    caption = suffix

    image.alt = alt
    image.caption = caption
    image.save

    puts product.slug
    puts image.path
    puts alt
    puts caption
    puts '---------'
  end

  count_after = ProductImage.count

  puts "Before: #{count_before}"
  puts "After: #{count_after}"
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
