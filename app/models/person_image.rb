# == Schema Information
#
# Table name: person_images
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_id   :string
#  person_id  :uuid
#
class PersonImage < ApplicationRecord
  belongs_to :person
  belongs_to :image
end
