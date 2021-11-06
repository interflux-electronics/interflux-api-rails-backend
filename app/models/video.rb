class Video < ApplicationRecord
  belongs_to :webinar, optional: true

  has_many :cdn_files
  alias_attribute :files, :cdn_files

  validates :title_admin, presence: true, uniqueness: true
  validates :title_public, presence: true, uniqueness: true
end
