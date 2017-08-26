# frozen_string_literal: true

require 'test_helper'

class ProductsTest < ActionDispatch::IntegrationTest
  def setup
    @IF_2005M = products('IF_2005M')
    @OSPI_3311M = products('OSPI_3311M')
    @DP_5600 = products('DP_5600')
    @QF_70 = products('QF_70')
    @QF_50 = products('QF_50')
  end

  test 'Admin can fetch a products by ID' do
    get "/admin/products/#{@IF_2005M.id}"
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal @IF_2005M.id, data['id'].to_i
    assert_equal @IF_2005M.name, data['attributes']['name']
  end

  test 'Admin can fetch all products' do
    get '/admin/products'
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal data.length, 5, 'Should return 5 products'
    refute_empty data.find { |p| p['id'].to_i == @IF_2005M.id }, 'Should contain IF 2005M'
    refute_empty data.find { |p| p['id'].to_i == @OSPI_3311M.id }, 'Should contain OSPI 3311M'
    refute_empty data.find { |p| p['id'].to_i == @DP_5600.id }, 'Should contain DP 5600'
    refute_empty data.find { |p| p['id'].to_i == @QF_70.id }, 'Should contain QF 70'
    refute_empty data.find { |p| p['id'].to_i == @QF_50.id }, 'Should contain QF 50'
  end

  test 'Admin can create a new product' do
    params = {
      product: {
        name: 'New Product',
        product_type: 'soldering_flux',
        pitch: 'Lorem ipsum.'
      }
    }
    assert_equal Product.count, 5, 'Before creation there should be 5 products'
    post '/admin/products', params: params
    data = JSON.parse(@response.body)['data']
    assert_response 201
    assert_equal Product.count, 6, 'After creation there should be 6 products'
    refute_empty Product.where(name: 'New Product'), 'Database should contain a new product named New Product'
  end

  test 'Admin can update a product' do
    params = {
      product: {
        visible: false
      }
    }
    assert_equal @IF_2005M.id, true
    put "/admin/products/#{@IF_2005M.id}", params: params
    assert_response 200
    assert_equal @IF_2005M.id, false
  end
  #
  # test 'Admin can create a product' do
  #   post '/admin/products', params: { product: { name: 'New Product', product_type: 'soldering_flux', pitch: 'Lorem ipsum.' } }
  #   assert_response 200
  # end
end
