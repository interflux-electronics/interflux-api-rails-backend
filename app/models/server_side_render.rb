# == Schema Information
#
# Table name: server_side_renders
#
#  id         :uuid             not null, primary key
#  host       :string
#  ip         :string
#  referrer   :string
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  visit_id   :uuid
#
class ServerSideRender < ApplicationRecord
  belongs_to :visit, optional: true, dependent: nil
end
