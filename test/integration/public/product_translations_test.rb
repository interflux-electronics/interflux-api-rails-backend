# require 'test_helper'
#
# class PublicProductTranslationTest < ActionDispatch::IntegrationTest
#   def setup
#     @product = products('IF_2005M')
#     @translation_french = product_translations('translation_IF_2005M_fr')
#     @translation_german = product_translations('translation_IF_2005M_de')
#     @german = languages('german')
#     @chinese = languages('chinese')
#   end
#
#   # TODO
#   # describe 'GET' do
#   #   describe '#index' do
#   #     it 'does not return translations without product_slug param' do
#   #       get '/admin/product-translations', headers: @authorized_header
#   #       assert_response 403
#   #     end
#   #
#   #     it 'return all translation of 1 specific product' do
#   #       get "/admin/product-translations?product=#{@product.id}"
#   #       assert_response 200
#   #       data = JSON.parse(@response.body)['data']
#   #       assert_equal data.length, 2, 'Should return 2 translations'
#   #       refute_empty data.find { |p| p['id'].to_i == @translation_french.id }
#   #       refute_empty data.find { |p| p['id'].to_i == @translation_german.id }
#   #     end
#   #   end
#   #
#   #   describe '#show' do
#   #     it 'returns translation by ID' do
#   #       get "/admin/product-translations/#{@translation_french.id}"
#   #       assert_response 200
#   #       data = JSON.parse(@response.body)['data']
#   #       assert_equal data['id'].to_i, @translation_french.id
#   #       assert_equal data['attributes']['language'], @translation_french.language
#   #     end
#   #     it 'returns 422 for bogus ID' do
#   #       get '/admin/product-translations/123'
#   #       assert_response 422
#   #     end
#   #   end
#   # end
#
#   describe 'POST' do
#     it 'is forbidden' do
#       post '/public/product-translations', params: {}
#       assert_response 403
#     end
#   end
#
#   describe 'PUT' do
#     it 'is forbidden' do
#       put "/public/product-translations/#{@translation_french.id}", params: {}
#       assert_response 403
#     end
#   end
#
#   describe 'DELETE' do
#     it 'is forbidden' do
#       delete "/public/product-translations/#{@translation_french.id}"
#       assert_response 403
#     end
#   end
# end
