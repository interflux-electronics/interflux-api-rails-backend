puts '---------'
puts 'Randomly ranking product images'
puts '---------'

Product.all.each do |product|
  puts product.name
  relations = product.product_images.shuffle
  relations.each_with_index do |rel, i|
    ii = i + 1
    puts "#{ii} - #{rel.id}"
    rel.rank = ii
    rel.save!
  end
end

puts '---------'
puts 'Success!'
puts '---------'
puts ' '
