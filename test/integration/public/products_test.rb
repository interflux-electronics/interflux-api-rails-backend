# frozen_string_literal: true

require 'test_helper'

class IntegrationTestPublicProduct < ActionDispatch::IntegrationTest
  def setup
    @product1 = products('IF_2005M')
    @product2 = products('OSPI_3311M')
    @product3 = products('DP_5600')
    @product4 = products('QF_70')
    @product5 = products('QF_50')
  end

  test 'Public can not fetch a products by ID' do
    get "/public/products/#{@product1.id}"
    assert_response 405
  end

  test 'Public can fetch a product by slug' do
    get "/public/products?slug=#{@product1.slug}"
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal data['id'].to_i, @product1.id
    assert_equal data['attributes']['name'], @product1.name
  end

  test 'Public cannot fetch products which are not public ' do
    get "/public/products/#{@product5.id}"
    assert_response 405
  end

  test 'Public can fetch all public products' do
    get '/public/products'
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal data.length, 4, 'Should return 4 products'
    refute_empty data.find { |p| p['id'].to_i == @product1.id }, 'Should contain IF 2005M'
    refute_empty data.find { |p| p['id'].to_i == @product2.id }, 'Should contain OSPI 3311M'
    refute_empty data.find { |p| p['id'].to_i == @product3.id }, 'Should contain DP 5600'
    refute_empty data.find { |p| p['id'].to_i == @product4.id }, 'Should contain QF 70'
    assert_empty data.find { |p| p['id'].to_i == @product5.id }, 'Should not contain QF 50'
  end

  test 'Public cannot create products' do
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
    post '/public/products', params: json
    assert_response 405
  end

  test 'Public cannot update a product' do
    json = {
      data: {
        attributes: {
          name: 'IF 2005M X'
        },
        id: @product1.id,
        type: 'products'
      }
    }
    put "/public/products/#{@product1.id}", params: json
    assert_response 405
  end

  test 'Public cannot delete a product' do
    assert_equal Product.count, 5, 'Before deletion there should be 5 products'
    delete "/public/products/#{@product1.id}"
    assert_equal Product.count, 5, 'After deletion there should still be 5 products'
  end
end
