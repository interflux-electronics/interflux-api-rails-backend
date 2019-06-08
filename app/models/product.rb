# == Schema Information
#
# Table name: products
#
#  id                :uuid             not null, primary key
#  slug              :string
#  code              :string
#  name              :string
#  public            :boolean          default(FALSE)
#  deprecated        :boolean          default(FALSE)
#  orderable         :boolean          default(FALSE)
#  popular           :boolean          default(FALSE)
#  new               :boolean          default(FALSE)
#  product_family_id :uuid
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Product < ApplicationRecord
  belongs_to :product_family

  has_many :product_processes
  has_many :product_variants
  has_many :containers, through: :product_variants
  has_many :soldering_processes, through: :product_processes, source: :soldering_process

  alias_attribute :family, :product_family
  alias_attribute :variants, :product_variants
  alias_attribute :processes, :soldering_processes
end
