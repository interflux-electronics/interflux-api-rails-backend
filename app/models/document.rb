# == Schema Information
#
# Table name: documents
#
#  path                 :string           not null, primary key
#  name                 :string
#  language_id          :string
#  document_category_id :uuid
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Document < ApplicationRecord
  belongs_to :language

  belongs_to :document_category
  alias_attribute :category, :document_category
end
