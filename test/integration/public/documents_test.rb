# frozen_string_literal: true

require 'test_helper'

class IntegrationTestPublicDocument < ActionDispatch::IntegrationTest
  def setup
    @document1 = documents('document_1')
    @document2 = documents('document_2')
    @document3 = documents('document_3')
    @document4 = documents('document_4')
  end

  test 'Public can fetch all public documents of the same type' do
    get "/public/documents?document_type=#{@document1.document_type}"
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal data.length, 2, 'Should return 2 documents'
  end

  test 'Public can fetch all public documents' do
    get '/public/documents'
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert data.length == 3, 'Should return 3 documents'
    assert data.find { |p| p['id'].to_i == @document1.id }.present?, 'Should contain document 1'
    assert data.find { |p| p['id'].to_i == @document2.id }.present?, 'Should contain document 2'
    assert data.find { |p| p['id'].to_i == @document3.id }.nil?, 'Should NOT contain document 3'
    assert data.find { |p| p['id'].to_i == @document4.id }.present?, 'Should contain document 4'
  end

  # TODO
  # test 'Public cannot fetch a documents by ID' do
  #   get "/public/documents/#{@document1.id}"
  #   assert_response 405
  # end

  # TODO
  # test 'Public cannot create documents' do
  #   json = {
  #     data: {
  #       attributes: {
  #         name: 'New Document',
  #         slug: nil,
  #         public: false,
  #         document_type: 'soldering_flux',
  #         pitch: nil,
  #         corpus: nil
  #       },
  #       type: 'documents'
  #     }
  #   }
  #   post '/public/documents', params: json
  #   assert_response 405
  # end

  # TODO
  # test 'Public cannot update a document' do
  #   json = {
  #     data: {
  #       attributes: {
  #         name: 'IF 2005M X'
  #       },
  #       id: @document1.id,
  #       type: 'documents'
  #     }
  #   }
  #   put "/public/documents/#{@document1.id}", params: json
  #   assert_response 405
  # end

  # TODO
  # test 'Public cannot delete a document' do
  #   assert_equal Document.count, 5, 'Before deletion there should be 5 documents'
  #   delete "/public/documents/#{@document1.id}"
  #   assert_equal Document.count, 5, 'After deletion there should still be 5 documents'
  # end
end
