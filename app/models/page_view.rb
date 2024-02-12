# == Schema Information
#
# Table name: page_views
#
#  id                 :uuid             not null, primary key
#  path               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  browser_session_id :uuid
#
class PageView < ApplicationRecord
  belongs_to :visit
end
