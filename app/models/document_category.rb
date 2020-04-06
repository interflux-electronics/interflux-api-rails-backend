# == Schema Information
#
# Table name: document_categories
#
#  id         :uuid             not null, primary key
#  slug       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DocumentCategory < ApplicationRecord
  has_many :documents
end
