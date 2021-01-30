# == Schema Information
#
# Table name: webinars
#
#  id         :uuid             not null, primary key
#  title      :string
#  topic      :string
#  audience   :string
#  url        :string
#  public     :boolean          default(FALSE)
#  start_time :bigint(8)
#  duration   :integer
#  person_id  :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Webinar < ApplicationRecord
  belongs_to :person, optional: true

  has_many :webinar_invitees, dependent: :destroy
  has_many :invitees, through: :webinar_invitees, source: :person
end
