# == Schema Information
#
# Table name: cdn_files
#
#  id          :uuid             not null, primary key
#  path        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image_id    :string
#  document_id :string
#

class CdnFile < ApplicationRecord
  belongs_to :image, optional: true
  belongs_to :document, optional: true

  validates :path, presence: true, uniqueness: true

  scope :fonts, -> { where "path LIKE :prefix", prefix: "fonts/%" }
  scope :images, -> { where "path LIKE :prefix", prefix: "images/%" }
  scope :documents, -> { where "path LIKE :prefix", prefix: "documents/%" }
end
