class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def log
    Rails.logger
  end
end
