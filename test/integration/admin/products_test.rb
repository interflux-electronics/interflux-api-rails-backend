# frozen_string_literal: true

require 'test_helper'

class IntegrationTestAdminProduct < ActionDispatch::IntegrationTest
  def setup
    @product1 = products('IF_2005M')
    @product2 = products('OSPI_3311M')
    @product3 = products('DP_5600')
    @product4 = products('QF_70')
    @product5 = products('QF_50')
  end

  test 'Admin can fetch a products by ID' do
    get "/admin/products/#{@product1.id}"
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal data['id'].to_i, @product1.id
    assert_equal data['attributes']['name'], @product1.name
  end

  test 'Admin can fetch all products' do
    get '/admin/products'
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal data.length, 5, 'Should return 5 products'
    refute_empty data.find { |p| p['id'].to_i == @product1.id }, 'Should contain IF 2005M'
    refute_empty data.find { |p| p['id'].to_i == @product2.id }, 'Should contain OSPI 3311M'
    refute_empty data.find { |p| p['id'].to_i == @product3.id }, 'Should contain DP 5600'
    refute_empty data.find { |p| p['id'].to_i == @product4.id }, 'Should contain QF 70'
    refute_empty data.find { |p| p['id'].to_i == @product5.id }, 'Should contain QF 50'
  end

  test 'Admin can create a product' do
    json = {
      data: {
        attributes: {
          name: 'New Product',
          slug: nil,
          visible: false,
          product_type: 'soldering_flux',
          pitch: nil,
          corpus: nil
        },
        type: 'products'
      }
    }
    assert_equal Product.count, 5, 'Before creation there should be 5 products'
    post '/admin/products', params: json
    assert_response 201
    assert_equal Product.count, 6, 'After creation there should be 6 products'
    refute_empty Product.where(name: 'New Product'), 'The database should contain a new product named "New Product"'
    product = Product.where(name: 'New Product').first
    data = JSON.parse(@response.body)['data']
    assert_equal data['id'].to_i, product.id, 'The response includes the ID of the created product (important)'
    assert_equal data['attributes']['name'], 'New Product'
  end

  test 'Admin can update a product 2' do
    json = {
      data: {
        attributes: {
          name: 'IF 2005M X'
        },
        id: @product1.id,
        type: 'products'
      }
    }
    assert_equal @product1.name, 'IF 2005M', 'Before the test name of the product should be "IF 2005M"'
    put "/admin/products/#{@product1.id}", params: json
    assert_response 204
    product = Product.find_by(id: @product1.id)
    assert_equal product.name, 'IF 2005M X', 'Adfter the test name of the product should be "IF 2005M X"'
  end

  test 'Admin can delete a product' do
    assert_equal Product.count, 5, 'Before deletion there should be 5 products'
    refute_empty Product.where(name: @product1.name), 'Before deletion the database should contain a product with name "IF 2005M"'
    delete "/admin/products/#{@product1.id}"
    assert_equal Product.count, 4, 'After deletion there should be 4 products'
    assert_empty Product.where(name: @product1.name), 'After deletion the database should no longer contain a product with name "IF 2005M"'
  end
end
