

# == Schema Information
#
# Table name: documents
#
#  id            :integer          not null, primary key
#  name          :string
#  url           :string
#  document_type :string
#  locale        :string
#  public        :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Document < ApplicationRecord
  has_many :products
end
