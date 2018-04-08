module Admin
  class ImageSerializer < ApplicationSerializer
    attributes :alt

    # https://github.com/Netflix/fast_jsonapi/issues/72
    belongs_to :image_owner, polymorphic: { Product => :product }

    has_many :image_sources
    has_many :image_translations
  end
end
