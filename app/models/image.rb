class Image < ApplicationRecord
  has_many :product_images, dependent: :destroy
  has_many :products, through: :product_images, source: :product

  has_many :person_images, dependent: :destroy
  has_many :people, through: :person_images, source: :person

  belongs_to :company, optional: true
  alias_attribute :copyright_by, :company

  has_many :cdn_files
  alias_attribute :files, :cdn_files

  validates :alt, presence: true, uniqueness: true
end
