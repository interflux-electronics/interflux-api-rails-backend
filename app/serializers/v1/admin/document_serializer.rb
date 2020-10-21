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
      belongs_to :document_category

      has_many :products, if: Proc.new { |record, params|
        params && params['include'] && params['include'].split(',').include?('products')
      }
    end
  end
end
