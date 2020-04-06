# == Schema Information
#
# Table name: articles
#
#  id                  :uuid             not null, primary key
#  slug                :string
#  title               :string
#  public              :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  body                :text
#  date                :date
#  article_category_id :uuid
#

class Article < ApplicationRecord
  belongs_to :article_category
  alias_attribute :category, :article_category
end
