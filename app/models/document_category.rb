# == Schema Information
#
# Table name: document_categories
#
#  created_at :datetime         not null
#  gist       :string
#  icon       :string
#  name       :string
#  order      :integer
#  slug       :string           not null, primary key
#  updated_at :datetime         not null
#

class DocumentCategory < ApplicationRecord
  has_many :documents
end
