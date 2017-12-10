# frozen_string_literal: true

require 'test_helper'

class AdminLanguagesIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    admin_user = users('admin_user')
    user_token = JsonWebToken.encode(user_id: admin_user.id)
    @authorized_header = { 'Authorization': user_token }
  end

  # REQUESTS WITHOUT AUTHENTICATION

  # test 'Nobody can GET "/admin/products" without authentication' do
  #   get '/admin/products'
  #   assert_response 401
  # end
  #
  # test 'Nobody can GET "/admin/products/:id" without authentication' do
  #   get "/admin/products/#{@product1.id}"
  #   assert_response 401
  # end
  #
  # test 'Nobody can POST "/admin/products" without authentication' do
  #   post '/admin/products', params: {}
  #   assert_response 401
  # end
  #
  # test 'Nobody can PUT "/admin/products/:id" without authentication' do
  #   put "/admin/products/#{@product1.id}", params: {}
  #   assert_response 401
  # end
  #
  # test 'Nobody can DELETE "/admin/products/:id" without authentication' do
  #   delete "/admin/products/#{@product1.id}"
  #   assert_response 401
  # end

  # REQUESTS WITH AUTHENTICATION

  test 'Authorized admin users can fetch all languages' do
    get '/admin/languages', headers: @authorized_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal data.length, 14, 'Should return 14 languages'
  end

  # test 'Authorized admin cannot can fetch a product group by ID' do
  #   get "/admin/product-groups/#{@product1.id}", headers: @authorized_header
  #   assert_response 401
  # end

  # test 'Authorized admin users can create a product' do
  #   json = {
  #     data: {
  #       attributes: {
  #         name: 'New Product',
  #         slug: nil,
  #         public: false,
  #         product_type: 'soldering_flux',
  #         pitch: nil,
  #         body: nil
  #       },
  #       type: 'products'
  #     }
  #   }
  #   assert_equal Product.count, 5, 'Before creation there should be 5 products'
  #   post '/admin/products', params: json, headers: @authorized_header
  #   assert_response 201
  #   assert_equal Product.count, 6, 'After creation there should be 6 products'
  #   refute_empty Product.where(name: 'New Product'), 'The database should contain a new product named "New Product"'
  #   product = Product.where(name: 'New Product').first
  #   data = JSON.parse(@response.body)['data']
  #   assert_equal data['id'].to_i, product.id, 'The response includes the ID of the created product (important)'
  #   assert_equal data['attributes']['name'], 'New Product'
  #   assert_equal data['attributes']['slug'], 'new-product'
  # end

  # test 'Authorized admin users can update a product' do
  #   json = {
  #     data: {
  #       attributes: {
  #         name: 'IF 2005M X',
  #         slug: 'IF-2005M-X'
  #       },
  #       id: @product1.id,
  #       type: 'products'
  #     }
  #   }
  #   assert_equal @product1.name, 'IF 2005M', 'Before the update the name of the product should be "IF 2005M"'
  #   put "/admin/products/#{@product1.id}", params: json, headers: @authorized_header
  #   assert_response 204
  #   product = Product.find_by(id: @product1.id)
  #   assert_equal product.name, 'IF 2005M X', 'After the update the name of the product should be "IF 2005M X"'
  #   assert_equal product.slug, 'IF-2005M-X', 'After the update the slug of the product should be "IF-2005M-X"'
  # end

  # test 'Authorized admin users can delete a product' do
  #   assert_equal Product.count, 5, 'Before deletion there should be 5 products'
  #   refute_empty Product.where(name: @product1.name), 'Before deletion the database should contain a product with name "IF 2005M"'
  #   delete "/admin/products/#{@product1.id}", headers: @authorized_header
  #   assert_equal Product.count, 4, 'After deletion there should be 4 products'
  #   assert_empty Product.where(name: @product1.name), 'After deletion the database should no longer contain a product with name "IF 2005M"'
  # end

  # test 'Admin cannot make a product with a name that already exists' do
  #   json = {
  #     data: {
  #       attributes: {
  #         name: @product1.name,
  #         slug: nil,
  #         public: false,
  #         product_type: 'soldering_flux',
  #         pitch: nil,
  #         body: nil
  #       },
  #       type: 'products'
  #     }
  #   }
  #   assert_equal Product.count, 5, 'Before creation there should be 5 products'
  #   post '/admin/products', params: json, headers: @authorized_header
  #   assert_equal Product.count, 5, 'After error creation there should be still 5 products'
  #   assert_response 422
  #   first_error = JSON.parse(@response.body)['errors'][0]
  #   assert_equal first_error['status'], '401'
  #   assert_equal first_error['code'], 'missing-header'
  #   assert_equal first_error['detail'], 'The header of your request is missing the Authorization field.'
  # end
end
