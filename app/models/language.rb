# == Schema Information
#
# Table name: languages
#
#  two_letter_code   :string           not null, primary key
#  name_english      :string
#  name_native       :string
#  three_letter_code :string
#  public            :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Language < ApplicationRecord

end
