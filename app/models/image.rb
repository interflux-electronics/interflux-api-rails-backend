# == Schema Information
#
# Table name: images
#
#  path       :string           not null, primary key
#  sizes      :string
#  formats    :string
#  caption    :string
#  alt        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ApplicationRecord
end
