# == Schema Information
#
# Table name: webinars
#
#  id          :uuid             not null, primary key
#  audience    :string
#  duration    :integer
#  public      :boolean          default(FALSE)
#  start_time  :bigint
#  title       :string
#  topic       :string
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  document_id :string
#  image_id    :string
#  person_id   :uuid
#  video_id    :string
#
class Webinar < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :image, optional: true
  belongs_to :video, optional: true
  belongs_to :document, optional: true

  has_many :webinar_invitees, dependent: :destroy
  has_many :webinar_attendees, dependent: :destroy
end
