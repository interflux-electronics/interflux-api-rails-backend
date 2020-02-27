# == Schema Information
#
# Table name: images
#
#  id         :uuid             not null, primary key
#  path       :string
#  sizes      :string
#  formats    :string
#  tag_long   :string
#  tag_short  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ApplicationRecord
end
