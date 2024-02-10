# == Schema Information
#
# Table name: document_categories
#
#  gist        :string
#  icon        :string
#  name        :string
#  name_single :string
#  order       :integer
#  slug        :string           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class DocumentCategory < ApplicationRecord
  has_many :documents
end
