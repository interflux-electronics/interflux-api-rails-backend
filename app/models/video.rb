# == Schema Information
#
# Table name: videos
#
#  id         :uuid             not null, primary key
#  cdn_path   :string
#  sizes      :string
#  formats    :string
#  tag_long   :string
#  tag_short  :string
#  poster_url :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Video < ApplicationRecord
end
