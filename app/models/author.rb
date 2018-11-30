# == Schema Information
#
# Table name: authors
#
#  id         :uuid             not null, primary key
#  tagline    :string
#  person_id  :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Author < ApplicationRecord
  belongs_to :person
end
