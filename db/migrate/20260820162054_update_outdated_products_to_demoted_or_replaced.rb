class UpdateOutdatedProductsToDemotedOrReplaced < ActiveRecord::Migration[6.1]
  def up
    Product.where(status: 'outdated', superior_product_id: nil).update_all(status: 'demoted')
    Product.where(status: 'outdated').where.not(superior_product_id: nil).update_all(status: 'replaced')
  end

  def down
    Product.where(status: %w[demoted replaced]).update_all(status: 'outdated')
  end
end
