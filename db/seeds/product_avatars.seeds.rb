# after :product_images do
  puts '---------'
  puts 'Linking product avatars'
  puts '---------'

  Product.all.each do |product|
    next if product.images.empty?
    image = product.images.shuffle.first
    byebug if image.nil?
    puts image.path
    product.avatar = image
    product.save!
  end

  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
# end
