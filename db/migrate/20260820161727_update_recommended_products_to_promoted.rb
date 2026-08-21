class UpdateRecommendedProductsToPromoted < ActiveRecord::Migration[6.1]
  def up
    Product.where(status: 'recommended').update_all(status: 'promoted')
  end

  def down
    Product.where(status: 'promoted').update_all(status: 'recommended')
  end
end
