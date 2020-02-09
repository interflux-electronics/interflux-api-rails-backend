require 'byebug'
require 'ap'

after :products, :images do
  puts '---------'
  puts 'Seeding product images'
  puts '---------'

  # The source of truth for images is the CDN, not the database. Therefor we
  # always delete images before seeding. Note that this will break all relations
  # to these images.
  ProductImage.delete_all

  before = ProductImage.count

  file = File.read 'db/seeds/images.yml'
  list = YAML.safe_load(file)

  list.each_with_index do |image, i|
    image = OpenStruct.new(image)
    image = Image.find_by(cdn_path: image.cdn_path)

    byebug if image.nil?

    # CDN paths look like this, no domain, no file extension
    # /images/products/IF-2005M/IF-2005M-10L-front
    # /images/processes/soldering-defects
    # /images/logos/interflux-logo
    # Not all files in the CDN are product images.
    # Continue only if product image.
    next unless image.cdn_path.starts_with? '/images/products/'

    slug = image.cdn_path.split('/')[3]
    product = Product.find_by(slug: slug)

    if product.nil?
      puts '/////'
      puts "No product found for slug: #{slug}"
      puts 'Skipping...'
      puts '/////'
      next
    end

    puts "#{i + 1} - #{product.slug} - #{image.cdn_path}"

    props = OpenStruct.new(
      product_id: product.id,
      image_id: image.id,
    )

    record = ProductImage.where(image_id: image.id, product_id: product.id).first

    if record.nil?
      ProductImage.create!(props.to_h)
    else
      record.update!(props.to_h)
    end
  end

  puts '---------'
  after = ProductImage.count
  difference = after - before
  puts "Before seeding, the database had #{before} images."
  puts "After seeding, the database has #{after}."
  puts "That's #{difference} new ones."
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
