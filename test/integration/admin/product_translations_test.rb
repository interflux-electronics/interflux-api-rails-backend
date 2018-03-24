require 'test_helper'

class AdminProductTranslationTest < ActionDispatch::IntegrationTest
  def setup
    @product = products('IF_2005M')
    @translation_french = product_translations('translation_IF_2005M_fr')
    @translation_german = product_translations('translation_IF_2005M_de')
    @french = languages('french')
    @german = languages('german')
    @chinese = languages('chinese')
  end

  test 'Users can fetch all translations of a single product' do
    get "/admin/product-translations/?slug=#{@product.slug}", headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Array, data.class
    assert_equal 2, data.length
  end

  test 'Users cannot fetch all translations' do
    get '/admin/product-translations', headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 422
  end

  test 'Users can fetch a single translation by ID' do
    get "/admin/product-translations/#{@translation_french.id}", headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Hash, data.class
    assert_equal data['id'], @translation_french.id
    assert_equal data['attributes']['body'], @translation_french.body
    assert_equal data['attributes']['pitch'], @translation_french.pitch
    assert_equal data['attributes'].length, 2
    assert_equal data['relationships']['product']['data']['id'], @translation_french.product.id
    assert_equal data['relationships']['language']['data']['id'], @translation_french.language.id
    assert_equal data['relationships'].length, 2
  end

  test 'Returns 422 for bogus IDs' do
    get '/admin/product-translations/123', headers: admin_header
    assert_response 422
  end

  test 'Returns 422 for bogus slugs' do
    get '/admin/product-translations/?slug=bogus', headers: admin_header
    assert_response 422
  end

  # TODO: Is this needed? Seems like it should be a side effect of creating a product and creating new languages
  test 'Users can create a translation' do
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
    post '/admin/product-translations', params: json, headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 201
    assert_equal Hash, data.class
    refute_equal data['id'], ProductTranslation.last.id
    assert_equal data['attributes']['body'], '招商好'
    assert_equal data['attributes']['pitch'], '吃饭'
    assert_equal data['attributes'].length, 2
    assert_equal data['relationships']['product']['data']['id'], @product.id
    assert_equal data['relationships']['language']['data']['id'], @chinese.id
    assert_equal data['relationships'].length, 2
  end

  test 'Users can update a translation' do
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
    put "/admin/product-translations/#{@translation_french.id}", params: json, headers: admin_header
    assert_response 204
    product = ProductTranslation.find_by(id: @translation_french.id)
    assert_equal product.pitch, '吃饭 interflux'
    assert_equal product.body, '招商好 interflux'
  end

  # TODO: Is this needed? Seems like it should be a side effect of creating a product and creating new languages
  test 'Users can delete a translation' do
    id = @translation_french.id
    refute_nil ProductTranslation.find_by(id: id)
    delete "/admin/product-translations/#{id}", headers: admin_header
    assert_nil ProductTranslation.find_by(id: id)
  end

  test 'Unauthorized requests' do
    get '/admin/product-translations'
    assert_response 401
    get "/admin/product-translations/#{@translation_french.id}"
    assert_response 401
    post '/admin/product-translations'
    assert_response 401
    put "/admin/product-translations/#{@translation_french.id}"
    assert_response 401
    delete "/admin/product-translations/#{@translation_french.id}"
    assert_response 401
  end
end
