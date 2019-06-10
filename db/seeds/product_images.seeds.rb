require 'byebug'
require 'ap'

after :products, :images do
  count_before = ProductImage.count

  puts '---------'
  puts 'Seeding product images'
  puts '---------'

  products = Product.all

  products.each_with_index do |product, i|
    puts "#{i + 1} - #{product.name}"

    product = Product.find_by(slug: product.slug)
    images = Image.where("cdn_path like ?", "%#{product.slug}%")

    images.each_with_index do |image, ii|
      puts "#{i}.#{ii}"

      properties = OpenStruct.new(
        product_id: product.id,
        image_id: image.id
      )

      record = ProductImage.where(product_id: product.id).where(image_id: image.id).first

      if record.nil?
        ProductImage.create!(properties.to_h)
      else
        record.update!(properties.to_h)
      end
    end
  end

  puts '---------'
  count_after = ProductImage.count
  difference = count_after - count_before
  puts "Before seeding, the database had #{count_before} images."
  puts "After seeding, the database has #{count_after}."
  puts "That's #{difference} new ones."
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
