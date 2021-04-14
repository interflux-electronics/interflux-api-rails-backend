class Product < ApplicationRecord
  belongs_to :product_family, optional: true
  alias_attribute :family, :product_family
  accepts_nested_attributes_for :product_family

  belongs_to :image, optional: true
  alias_attribute :avatar, :image

  has_many :product_qualities
  has_many :qualities, through: :product_qualities, source: :quality

  has_many :product_uses
  has_many :uses, through: :product_uses, source: :use

  has_many :product_images
  has_many :images, through: :product_images, source: :image

  has_many :product_documents
  has_many :documents, through: :product_documents, source: :document

  belongs_to :superior_product, optional: true

  # TODO: review
  has_many :product_variants
  has_many :variants, through: :product_variants, source: :product

  # TODO: review
  has_many :product_containers
  has_many :containers, through: :product_containers, source: :container

  validates :status, inclusion: { in: %w[new popular recommended outdated discontinued offline] }

  after_save :todo_after_save

  private

  # 1. Whenever a product is given the status "offline", set the public boolean to false so it is
  #    hidden from all our public facing websites.
  # 2. Avatar image properties are stored on the product so we can avoid 100 N+1 requests when
  #    serving all products to the frontend.
  def todo_after_save
    update_columns(
      public: status != 'offline',
      avatar_path: avatar ? avatar.path : nil,
      avatar_variations: avatar ? avatar.variations : nil,
      avatar_caption: avatar ? avatar.caption : nil,
      avatar_alt: avatar ? avatar.alt : nil
    )
  end
end
