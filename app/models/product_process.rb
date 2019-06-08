# == Schema Information
#
# Table name: product_processes
#
#  id                   :uuid             not null, primary key
#  product_id           :uuid
#  soldering_process_id :uuid
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class ProductProcess < ApplicationRecord
  belongs_to :product
  belongs_to :soldering_process
end
