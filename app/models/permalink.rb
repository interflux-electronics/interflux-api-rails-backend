# == Schema Information
#
# Table name: permalinks
#
#  id          :uuid             not null, primary key
#  notes       :string
#  redirect_to :string
#  slug        :string
#  event_id    :uuid
#
# Indexes
#
#  index_permalinks_on_slug  (slug) UNIQUE
#
class Permalink < ApplicationRecord
  belongs_to :event, optional: true

  validates :slug, presence: true, uniqueness: true
end
