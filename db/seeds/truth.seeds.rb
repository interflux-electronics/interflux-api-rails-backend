puts '---------'
puts 'Seeding all local sources of truth'
puts '---------'

# TODO: the idea is that this seed file becomes obsolete and production database
# becomes the source of truth created by users

Product.delete_all
ProductFamily.delete_all
ProductImage.delete_all
Image.delete_all

# product avatars triggers:
# products
# product families
# product images
after :product_avatars do
  puts '---------'
  puts 'Done seeding local sources of truth'
  puts '---------'
  puts ' '
end
