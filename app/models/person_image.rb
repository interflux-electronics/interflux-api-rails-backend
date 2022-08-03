class PersonImage < ApplicationRecord
  belongs_to :person
  belongs_to :image
end
