# == Schema Information
#
# Table name: articles
#
#  id         :uuid             not null, primary key
#  slug       :string
#  title      :string
#  tease      :string
#  author_id  :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
