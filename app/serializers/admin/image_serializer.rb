module Admin
  class ImageSerializer < ApplicationSerializer
    attributes :alt
    belongs_to :image_owner
    has_many :image_sources
    has_many :image_translations
  end
end
