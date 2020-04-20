puts '---------'
puts 'Seeding all local sources of truth'
puts '---------'

# TODO: the idea is that this seed file becomes obsolete and production database
# becomes the source of truth created by users

Product.delete_all
Image.delete_all
Document.delete_all
Feature.delete_all

ProductFamily.delete_all
ProductImage.delete_all
ProductDocument.delete_all
ProductFeature.delete_all

Article.delete_all
ArticleCategory.delete_all

Country.delete_all
Language.delete_all

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
# product_features
# triggers features and products
#
after :product_avatars, :product_documents, :product_features, :articles, :countries, :languages do
  puts '---------'
  puts 'Done seeding local sources of truth'
  puts '---------'
  puts ' '
end
