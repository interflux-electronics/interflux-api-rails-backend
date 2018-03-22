require 'test_helper'

class ApplicationTest < ActionDispatch::IntegrationTest
  describe 'Unknown routes' do
    describe 'GET' do
      describe '#index' do
        it 'returns 404' do
          get '/unknown'
          assert_response 404
        end
      end

      describe '#show' do
        it 'returns 404' do
          get '/unknown/123'
          assert_response 404
        end
      end
    end

    describe 'POST' do
      it 'returns 404' do
        post '/unknown/123'
        assert_response 404
      end
    end

    describe 'PUT' do
      it 'returns 404' do
        put '/unknown/123'
        assert_response 404
      end
    end

    describe 'DELETE' do
      it 'returns 404' do
        delete '/unknown/123'
        assert_response 404
      end
    end
  end
end
