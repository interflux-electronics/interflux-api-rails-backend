# == Schema Information
#
# Table name: image_translations
#
#  id          :integer          not null, primary key
#  caption     :string
#  image_id    :integer
#  language_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ImageTranslation < ApplicationRecord
  belongs_to :image
  belongs_to :language
end
