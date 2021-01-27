# == Schema Information
#
# Table name: webinars
#
#  id         :uuid             not null, primary key
#  topic      :string
#  blurb      :string
#  url        :string
#  start_time :bigint(8)
#  duration   :integer
#  public     :boolean          default(FALSE)
#  person_id  :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Webinar < ApplicationRecord
  belongs_to :person, optional: true
end
