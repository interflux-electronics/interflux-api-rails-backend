# == Schema Information
#
# Table name: client_side_renders
#
#  id                    :uuid             not null, primary key
#  host                  :string
#  ip                    :string
#  path                  :string
#  referrer              :string
#  user_agent            :string
#  viewport_height       :integer
#  viewport_width        :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  browser_session_id    :uuid
#  server_side_render_id :uuid
#  user_id               :uuid
#  visit_id              :uuid
#
class ClientSideRender < ApplicationRecord
  belongs_to :server_side_render, optional: true
  belongs_to :visit, optional: true
  belongs_to :user, optional: true
end
