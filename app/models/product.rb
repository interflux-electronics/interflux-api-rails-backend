# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id           :integer          not null, primary key
#  name         :string
#  slug         :string
#  product_type :string
#  public       :boolean          default(FALSE)
#  pitch        :string
#  corpus       :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Product < ApplicationRecord
  validates :name, presence: true
  validates :product_type, presence: true
end
