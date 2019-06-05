# == Schema Information
#
# Table name: product_series
#
#  id                :uuid             not null, primary key
#  slug              :string
#  code              :string
#  name              :string
#  public            :boolean          default(FALSE)
#  continued         :boolean          default(TRUE)
#  product_family_id :uuid
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ProductSerie < ApplicationRecord
  belongs_to :product_family

  has_many :product_processes
  has_many :soldering_processes, through: :product_processes, source: :soldering_process
  has_many :product_variants
  has_many :containers, through: :product_variants

  alias_attribute :family, :product_family
  alias_attribute :variants, :product_variants
  alias_attribute :processes, :soldering_processes
end
