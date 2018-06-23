# == Schema Information
#
# Table name: product_uses
#
#  id         :uuid             not null, primary key
#  slug       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Use < ApplicationRecord
end
