# require 'test_helper'
#
# class PublicProductCategoryTest < ActionDispatch::IntegrationTest
#   before do
#     @soldering_fluxes = product_categories('soldering_fluxes')
#     @voc_free = product_categories('voc_free')
#   end
#
#   describe 'GET' do
#     describe '#index' do
#       it 'returns all product categories' do
#         get '/public/product-categories'
#         assert_response 200
#         data = JSON.parse(@response.body)['data']
#         assert_equal data.length, 21, 'Should return 21 categories'
#         refute_empty data.find { |p| p['id'].to_i == @soldering_fluxes.id }, 'Should contain soldering fluxes'
#         refute_empty data.find { |p| p['id'].to_i == @voc_free.id }, 'Should contain VOC-free soldering fluxes'
#       end
#       it 'return all sub categories of soldering-fluxes' do
#         get '/public/product-categories?filter[parent-category]=soldering-fluxes'
#         assert_response 200
#         data = JSON.parse(@response.body)['data']
#         assert_equal data.length, 6, 'Should return 6 categories'
#         assert_nil data.find { |p| p['id'].to_i == @soldering_fluxes.id }, 'Should not contain soldering fluxes'
#         refute_empty data.find { |p| p['id'].to_i == @voc_free.id }, 'Should contain VOC-free soldering fluxes'
#       end
#     end
#
#     describe '#show' do
#       it 'returns product category by ID' do
#         get "/public/product-categories/#{@soldering_fluxes.id}"
#         assert_response 200
#         data = JSON.parse(@response.body)['data']
#         assert_equal data['id'].to_i, @soldering_fluxes.id
#         assert_equal data['attributes']['name-plural'], @soldering_fluxes.name_plural
#       end
#       it 'returns product category by slug' do
#         get "/public/product-categories/?slug=#{@soldering_fluxes.slug}"
#         assert_response 200
#         data = JSON.parse(@response.body)['data']
#         assert_equal data['id'].to_i, @soldering_fluxes.id
#         assert_equal data['attributes']['name-plural'], @soldering_fluxes.name_plural
#       end
#       it 'returns 422 for bogus ID' do
#         get '/public/product-categories/?slug=123'
#         assert_response 422
#       end
#       it 'returns 422 for bogus slug' do
#         get '/public/product-categories/?slug=bogus'
#         assert_response 422
#       end
#     end
#   end
#
#   describe 'POST' do
#     it 'should be forbidden' do
#       post '/public/products'
#       assert_response 403
#     end
#   end
#
#   describe 'PUT' do
#     it 'should be forbidden' do
#       put "/public/products/#{@soldering_fluxes.id}"
#       assert_response 403
#     end
#   end
#
#   describe 'DELETE' do
#     it 'should be forbidden' do
#       delete "/public/products/#{@soldering_fluxes.id}"
#       assert_response 403
#     end
#   end
# end
