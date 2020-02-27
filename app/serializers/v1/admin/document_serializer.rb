# == Schema Information
#
# Table name: documents
#
#  id          :uuid             not null, primary key
#  path        :string
#  name        :string
#  language_id :uuid
#  category_id :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module V1
  module Admin
    class DocumentSerializer < ApplicationSerializer
      attributes :path,
                 :name

      belongs_to :language
      belongs_to :category
      # belongs_to :sub_group, record_type: :product_group, serializer: :product_group

      # has_many :things
      # has_many :related_products, record_type: :product, serializer: :related_products
      # has_many :related_articles, record_type: :article, serializer: :related_articles
    end
  end
end
