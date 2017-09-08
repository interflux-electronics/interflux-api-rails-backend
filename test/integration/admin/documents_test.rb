# frozen_string_literal: true

require 'test_helper'

class IntegrationTestAdminDocument < ActionDispatch::IntegrationTest
  def setup
    @document1 = documents('document_1')
    @document2 = documents('document_2')
    @document3 = documents('document_3')
    @document4 = documents('document_4')
  end

  test 'Admin can fetch a document by ID' do
    get "/admin/documents/#{@document1.id}"
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal data['id'].to_i, @document1.id
    assert_equal data['attributes']['name'], @document1.name
  end

  test 'Admin can fetch all documents' do
    get '/admin/documents'
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal data.length, 4, 'Should return 4 documents'
    refute_empty data.find { |p| p['id'].to_i == @document1.id }, 'Should contain document 1'
    refute_empty data.find { |p| p['id'].to_i == @document2.id }, 'Should contain document 2'
    refute_empty data.find { |p| p['id'].to_i == @document3.id }, 'Should contain document 3'
    refute_empty data.find { |p| p['id'].to_i == @document4.id }, 'Should contain document 4'
  end

  test 'Admin can create a document' do
    json = {
      data: {
        attributes: {
          name: 'New Document',
          slug: nil,
          public: false,
          document_type: 'soldering_flux',
          pitch: nil,
          corpus: nil
        },
        type: 'documents'
      }
    }
    assert_equal Document.count, 4, 'Before creation there should be 4 documents'
    post '/admin/documents', params: json
    assert_response 201
    assert_equal Document.count, 5, 'After creation there should be 5 documents'
    refute_empty Document.where(name: 'New Document'), 'The database should contain a new document named "New Document"'
    document = Document.where(name: 'New Document').first
    data = JSON.parse(@response.body)['data']
    assert_equal data['id'].to_i, document.id, 'The response includes the ID of the created document (important)'
    assert_equal data['attributes']['name'], 'New Document'
  end

  test 'Admin can update a document' do
    json = {
      data: {
        attributes: {
          name: 'TD IF 2005M'
        },
        id: @document1.id,
        type: 'documents'
      }
    }
    assert_equal @document1.name, 'Technical Data IF 2005M', 'Before the update the name of the document should be "Technical Data IF 2005M"'
    put "/admin/documents/#{@document1.id}", params: json
    assert_response 204
    document = Document.find_by(id: @document1.id)
    assert_equal document.name, 'TD IF 2005M', 'After the update the name of the document should be "TD IF 2005M"'
  end

  test 'Admin can delete a document' do
    assert Document.count == 4, 'Before deletion there should be 5 documents'
    assert Document.find_by(id: @document1.id).present?, "Before deletion the document with ID #{@document1.id} should exist"
    delete "/admin/documents/#{@document1.id}"
    assert Document.count == 3, 'After deletion there should be 4 documents'
    assert Document.find_by(id: @document1.id).nil?, "After deletion the document with ID #{@document1.id} should no longer exist"
  end

  # TODO: Make validations return JSON format 422
  # test 'Admin cannot make a document with a name that already exists' do
  #   json = {
  #     data: {
  #       attributes: {
  #         name: @document1.name,
  #         slug: nil,
  #         public: false,
  #         document_type: 'soldering_flux',
  #         pitch: nil,
  #         corpus: nil
  #       },
  #       type: 'documents'
  #     }
  #   }
  #   assert_equal Document.count, 5, 'Before creation there should be 5 documents'
  #   post '/admin/documents', params: json
  #   assert_response 422
  # end
end
