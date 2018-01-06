require 'test_helper'

class PublicProductTest < ActionDispatch::IntegrationTest
  before do
    @IF_2005M = products('IF_2005M')
    @OSPI_3311M = products('OSPI_3311M')
    @pacific_2009M = products('pacific_2009M')
    @DP_5600 = products('DP_5600')
    @QF_70 = products('QF_70')
    @QF_50 = products('QF_50')
  end

  describe 'GET' do
    describe '#index' do
      it 'return all active products' do
        get '/public/products'
        assert_response 200
        data = JSON.parse(@response.body)['data']
        assert_equal data.length, 5, 'Should return 5 products'
        refute_empty data.find { |p| p['id'].to_i == @IF_2005M.id }, 'Should contain IF 2005M'
        refute_empty data.find { |p| p['id'].to_i == @OSPI_3311M.id }, 'Should contain OSPI 3311M'
        refute_empty data.find { |p| p['id'].to_i == @pacific_2009M.id }, 'Should contain Pacific 2009M'
        refute_empty data.find { |p| p['id'].to_i == @DP_5600.id }, 'Should contain DP 5600'
        refute_empty data.find { |p| p['id'].to_i == @QF_70.id }, 'Should contain QF 70'
        assert_nil data.find { |p| p['id'].to_i == @QF_50.id }, 'Should not contain QF 50'
      end
      it 'return all active soldering fluxes' do
        get '/public/products?filter[main-category]=soldering-fluxes'
        assert_response 200
        data = JSON.parse(@response.body)['data']
        assert_equal data.length, 3, 'Should return 3 products'
        refute_empty data.find { |p| p['id'].to_i == @IF_2005M.id }, 'Should contain IF 2005M'
        refute_empty data.find { |p| p['id'].to_i == @OSPI_3311M.id }, 'Should contain OSPI 3311M'
        refute_empty data.find { |p| p['id'].to_i == @pacific_2009M.id }, 'Should contain Pacific 2009M'
        assert_nil data.find { |p| p['id'].to_i == @DP_5600.id }, 'Should contain DP 5600'
        assert_nil data.find { |p| p['id'].to_i == @QF_70.id }, 'Should contain QF 70'
        assert_nil data.find { |p| p['id'].to_i == @QF_50.id }, 'Should not contain QF 50'
      end
      it 'return all active VOC-free soldering fluxes' do
        get '/public/products?filter[sub-category]=VOC-free'
        assert_response 200
        data = JSON.parse(@response.body)['data']
        assert_equal data.length, 1, 'Should return 1 products'
        assert_nil data.find { |p| p['id'].to_i == @IF_2005M.id }, 'Should not contain IF 2005M'
        assert_nil data.find { |p| p['id'].to_i == @OSPI_3311M.id }, 'Should not contain OSPI 3311M'
        refute_empty data.find { |p| p['id'].to_i == @pacific_2009M.id }, 'Should contain Pacific 2009M'
        assert_nil data.find { |p| p['id'].to_i == @DP_5600.id }, 'Should not contain DP 5600'
        assert_nil data.find { |p| p['id'].to_i == @QF_70.id }, 'Should not contain QF 70'
        assert_nil data.find { |p| p['id'].to_i == @QF_50.id }, 'Should not contain QF 50'
      end
    end

    describe '#show' do
      it 'returns product by ID' do
        get "/public/products/#{@IF_2005M.id}"
        assert_response 200
        data = JSON.parse(@response.body)['data']
        assert_equal data['id'].to_i, @IF_2005M.id
        assert_equal data['attributes']['name'], @IF_2005M.name
      end
      it 'returns product by slug' do
        get "/public/products/?slug=#{@IF_2005M.slug}"
        assert_response 200
        data = JSON.parse(@response.body)['data']
        assert_equal data['id'].to_i, @IF_2005M.id
        assert_equal data['attributes']['name'], @IF_2005M.name
      end
      it 'returns 422 for bogus ID' do
        get '/public/products/?slug=123'
        assert_response 422
      end
      it 'returns 422 for bogus slug' do
        get '/public/products/?slug=bogus'
        assert_response 422
      end
    end
  end

  describe 'POST' do
    it 'should be forbidden' do
      post '/public/products'
      assert_response 403
    end
  end

  describe 'PUT' do
    it 'should be forbidden' do
      put "/public/products/#{@IF_2005M.id}"
      assert_response 403
    end
  end

  describe 'DELETE' do
    it 'should be forbidden' do
      delete "/public/products/#{@IF_2005M.id}"
      assert_response 403
    end
  end
end
