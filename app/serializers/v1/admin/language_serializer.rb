# == Schema Information
#
# Table name: languages
#
#  id             :uuid             not null, primary key
#  name_english   :string
#  name_native    :string
#  two_letter_code :string
#  three_letter_code :string
#  public         :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

module V1
  module Admin
    class LanguageSerializer < ApplicationSerializer
      attributes :name_english,
                 :name_native,
                 :two_letter_code,
                 :three_letter_code,
                 :public

      # belongs_to :thing
      # belongs_to :main_group, record_type: :product_group, serializer: :product_group
      # belongs_to :sub_group, record_type: :product_group, serializer: :product_group

      # has_many :things
      # has_many :related_products, record_type: :product, serializer: :related_products
      # has_many :related_articles, record_type: :article, serializer: :related_articles
    end
  end
end
