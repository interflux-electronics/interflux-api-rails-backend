require 'test_helper'

class AdminProductTranslationTest < ActionDispatch::IntegrationTest
  def setup
    @product = products('IF_2005M')
    @translation_french = product_translations('translation_IF_2005M_fr')
    @translation_german = product_translations('translation_IF_2005M_de')
    @german = languages('german')
    @chinese = languages('chinese')
  end

  describe 'without authentication' do
    describe 'GET' do
      describe '#index' do
        it 'returns 401' do
          get '/admin/product-translations'
          assert_response 401
        end
      end

      describe '#show' do
        it 'returns 401 by ID' do
          get "/admin/product-translations/#{@translation_french.id}"
          assert_response 401
        end
      end
    end

    describe 'POST' do
      it 'returns 401' do
        post '/admin/product-translations', params: {}
        assert_response 401
      end
    end

    describe 'PUT' do
      it 'returns 401' do
        put "/admin/product-translations/#{@translation_french.id}", params: {}
        assert_response 401
      end
    end

    describe 'DELETE' do
      it 'returns 401' do
        delete "/admin/product-translations/#{@translation_french.id}"
        assert_response 401
      end
    end
  end

  describe 'authenticated' do
    before do
      admin_user = users('admin_user')
      user_token = JsonWebToken.encode(user_id: admin_user.id)
      @authorized_header = { 'Authorization': user_token }
    end

    describe 'GET' do
      describe '#index' do
        it 'does not return translations without product_id param' do
          get '/admin/product-translations', headers: @authorized_header
          assert_response 422
        end

        it 'return all translations of 1 specific product' do
          get "/admin/product-translations?slug=#{@product.slug}", headers: @authorized_header
          assert_response 200
          data = JSON.parse(@response.body)['data']
          assert_equal data.length, 2, 'Should return 2 translations'
          refute_empty data.find { |p| p['id'].to_i == @translation_french.id }
          refute_empty data.find { |p| p['id'].to_i == @translation_german.id }
        end
      end

      describe '#show' do
        it 'returns translation by ID' do
          get "/admin/product-translations/#{@translation_french.id}", headers: @authorized_header
          assert_response 200
          data = JSON.parse(@response.body)['data']
          assert_equal data['id'].to_i, @translation_french.id
          assert_equal data['attributes']['language'], @translation_french.language
        end
        it 'returns 422 for bogus ID' do
          get '/admin/product-translations/123', headers: @authorized_header
          assert_response 422
        end
      end
    end

    describe 'POST' do
      it 'creates a translation' do
        json = {
          data: {
            type: 'product-translation',
            attributes: {
              pitch: '吃饭',
              body: '招商好'
            },
            relationships: {
              'product': {
                data: {
                  type: 'product',
                  id: @product.id
                }
              },
              'language': {
                data: {
                  type: 'language',
                  id: @chinese.id
                }
              }
            }
          }
        }
        post '/admin/product-translations', params: json, headers: @authorized_header
        assert_response 201
        translation = ProductTranslation.where(language: @chinese).first
        data = JSON.parse(@response.body)['data']
        assert_equal data['id'].to_i, translation.id, 'The response includes the ID of the created translation (important)'
        assert_equal data['attributes']['pitch'], '吃饭'
        assert_equal data['attributes']['body'], '招商好'
      end
    end

    describe 'PUT' do
      it 'updates a translation' do
        json = {
          data: {
            type: 'product-translation',
            attributes: {
              pitch: '吃饭 interflux',
              body: '招商好 interflux'
            },
            relationships: {
              'product': {
                data: {
                  type: 'product',
                  id: @product.id
                }
              },
              'language': {
                data: {
                  type: 'language',
                  id: @chinese.id
                }
              }
            }
          }
        }
        put "/admin/product-translations/#{@translation_french.id}", params: json, headers: @authorized_header
        assert_response 204
        product = ProductTranslation.find_by(id: @translation_french.id)
        assert_equal product.pitch, '吃饭 interflux'
        assert_equal product.body, '招商好 interflux'
      end
    end

    describe 'DELETE' do
      it 'deletes a translation' do
        id = @translation_german.id
        refute_nil ProductTranslation.find_by(id: id)
        delete "/admin/product-translations/#{id}", headers: @authorized_header
        assert_nil ProductTranslation.find_by(id: id)
      end
    end
  end
end
