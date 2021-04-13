class Article < ApplicationRecord
  belongs_to :article_category
  alias_attribute :category, :article_category
end
