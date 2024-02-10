# == Schema Information
#
# Table name: use_images
#
#  id                :uuid             not null, primary key
#  rank_among_images :integer
#  rank_among_uses   :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  image_id          :string
#  use_id            :string
#
class UseImage < ApplicationRecord
  belongs_to :use
  belongs_to :image
end
