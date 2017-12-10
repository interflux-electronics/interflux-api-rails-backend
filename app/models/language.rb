# frozen_string_literal: true

# == Schema Information
#
# Table name: languages
#
#  id           :integer          not null, primary key
#  locale       :string
#  name_english :string
#  name_native  :string
#

class Language < ApplicationRecord
end
