namespace :images do
  desc "Creates CSV with images to create"
  task list_todo: :environment do
    csv = "FAMILY,PRODUCT,VARIANT,CONTAINER\n"

    ProductFamily.all.each_with_index do |family, i|
      family.products.each_with_index do |product, ii|
        product.variants.each_with_index do |variant, iii|
          column_1 = family.name_plural if ii == 0 && iii == 0
          column_2 = product.name if iii == 0
          column_3 = variant.code
          column_4 = variant.container ? "\"#{variant.container.name}\"" : 'NA'
          column_5 = "\"#{variant.name}\""
          csv << [column_1, column_2, column_3, column_4, column_5].join(',')
          csv << "\n"
        end
      end
    end

    puts ap csv
  end
end
