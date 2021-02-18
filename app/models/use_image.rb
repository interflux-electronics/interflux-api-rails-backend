# == Schema Information
#
# Table name: use_images
#
#  id                :uuid             not null, primary key
#  use_id            :string
#  image_id          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  rank_among_uses   :integer
#  rank_among_images :integer
#

class UseImage < ApplicationRecord
  belongs_to :use
  belongs_to :image
end
