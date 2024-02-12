# == Schema Information
#
# Table name: server_side_renders
#
#  id         :uuid             not null, primary key
#  host       :string
#  ip         :string
#  path       :string
#  referrer   :string
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  visit_id   :uuid
#
class ServerSideRender < ApplicationRecord
  belongs_to :visit, optional: true

  has_one :client_side_render
end
