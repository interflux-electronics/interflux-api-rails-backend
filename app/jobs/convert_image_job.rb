#
# This sole responsability is scheduling image conversions asynchronously so they don't block HTTP requests.
#
class ConvertImageJob < ApplicationJob
  queue_as :default

  def perform(image)
    logger.info '======'
    logger.info 'ConvertImageJob start'

    ImageConversionService.new(image).run

    logger.info 'ConvertImageJob end'
    logger.info '======'
  end

  private

  def logger
    Rails.logger
  end
end
