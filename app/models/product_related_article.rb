class ProductRelatedArticle < ApplicationRecord
  belongs_to :product
  belongs_to :article
end
