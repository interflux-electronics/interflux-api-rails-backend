# == Schema Information
#
# Table name: images
#
#  id         :uuid             not null, primary key
#  path       :string
#  sizes      :string
#  formats    :string
#  caption    :string
#  alt        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ApplicationRecord
end
