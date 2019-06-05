# == Schema Information
#
# Table name: soldering_processes
#
#  id         :uuid             not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SolderingProcess < ApplicationRecord
  has_many :product_processes
  has_many :products, through: :product_processes, source: :product_serie
end
