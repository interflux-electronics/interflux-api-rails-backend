class Product < ApplicationRecord
  # key: label

  belongs_to :main_family, class_name: 'ProductFamily', optional: true
  belongs_to :sub_family, class_name: 'ProductFamily', optional: true

  # DEPRECATED
  belongs_to :product_family, optional: true
  alias_attribute :family, :product_family
  accepts_nested_attributes_for :product_family

  belongs_to :image, optional: true
  alias_attribute :avatar, :image

  has_many :product_qualities, dependent: :destroy
  has_many :qualities, through: :product_qualities, source: :quality

  has_many :product_uses, dependent: :destroy
  has_many :uses, through: :product_uses, source: :use

  has_many :product_images, dependent: :destroy
  has_many :images, through: :product_images, source: :image

  has_many :product_videos, dependent: :destroy
  has_many :videos, through: :product_videos, source: :video

  has_many :product_documents, dependent: :destroy
  has_many :documents, through: :product_documents, source: :document

  belongs_to :superior_product, optional: true

  # TODO: review
  # has_many :product_variants, dependent: :destroy
  # has_many :variants, through: :product_variants, source: :product

  # TODO: review
  # has_many :product_containers, dependent: :destroy
  # has_many :containers, through: :product_containers, source: :container

  validates :name, :slug, presence: true
  validates :status, inclusion: { in: %w[new popular recommended outdated discontinued offline] }

  after_save :todo_after_save

  private

  # 1. Whenever a product is given the status "offline", set the public boolean to false so it is
  #    hidden from all our public facing websites.
  # 2. Avatar image properties are stored on the product so we can avoid 100 N+1 requests when
  #    serving all products to the frontend.
  def todo_after_save
    old_slug = slug
    new_slug = name.gsub(/\s/, '-').gsub(/[^a-zA-Z0-9-]/, '')

    update_columns(
      slug: new_slug,
      public: status != 'offline',
      avatar_path: avatar ? avatar.path : nil,
      avatar_variations: avatar ? avatar.variations : nil,
      avatar_caption: avatar ? avatar.caption : nil,
      avatar_alt: avatar ? avatar.alt : nil
    )

    # All tables with product_id in them
    # product_complementary_products
    # product_complements
    # product_documents
    # product_features
    # product_images
    # product_qualities
    # product_related_articles
    # product_substitutes
    # product_uses
    # product_videos

    return if new_slug == old_slug

    ProductDocument
      .where(product_id: old_slug)
      .find_each { |x| x.update(product_id: new_slug) }

    ProductImage
      .where(product_id: old_slug)
      .find_each { |x| x.update(product_id: new_slug) }

    ProductVideo
      .where(product_id: old_slug)
      .find_each { |x| x.update(product_id: new_slug) }

    ProductQuality
      .where(product_id: old_slug)
      .find_each { |x| x.update(product_id: new_slug) }

    ProductUse
      .where(product_id: old_slug)
      .find_each { |x| x.update(product_id: new_slug) }

    # TODO: drop ProductComplementaryProduct
    # TODO: drop ProductComplement
    # TODO: drop ProductSubstitute
    # TODO: drop ProductRelatedArticle ?
    # TODO: drop ProductFeature ?
  end
end
