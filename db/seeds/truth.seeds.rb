puts '---------'
puts 'Seeding all local sources of truth'
puts '---------'

# TODO: the idea is that this seed file becomes obsolete and production database
# becomes the source of truth created by users

Product.delete_all
ProductFamily.delete_all
ProductImage.delete_all
Image.delete_all
ProductDocument.delete_all
Document.delete_all

# product avatars
# triggers product images
# triggers products and images
# triggers product families
#
# product_documents
# triggers documents and products
# triggers document_categories, languages, products
# triggers products families
#
after :product_avatars, :product_documents do
  puts '---------'
  puts 'Done seeding local sources of truth'
  puts '---------'
  puts ' '
end
