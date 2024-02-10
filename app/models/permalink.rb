# == Schema Information
#
# Table name: permalinks
#
#  id          :uuid             not null, primary key
#  notes       :string
#  redirect_to :string
#  slug        :string
#
class Permalink < ApplicationRecord
  # attr :redirect_from
  # attr :redirect_to
  # attr :notes
end
