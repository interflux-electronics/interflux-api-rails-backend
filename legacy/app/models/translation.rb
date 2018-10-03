# == Schema Information
#
# Table name: translations
#
#  id         :uuid             not null, primary key
#  slug       :string
#  en         :string
#  de         :string
#  fr         :string
#  zh         :string
#  cs         :string
#  it         :string
#  ind        :string
#  pt         :string
#  ro         :string
#  ru         :string
#  th         :string
#  tr         :string
#  pl         :string
#  es         :string
#  sv         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Translation < ApplicationRecord
end
