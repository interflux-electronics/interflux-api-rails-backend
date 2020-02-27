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

class Document < ApplicationRecord
  belongs_to :language
  belongs_to :category, class_name: 'DocumentCategory', foreign_key: 'category_id'
end
