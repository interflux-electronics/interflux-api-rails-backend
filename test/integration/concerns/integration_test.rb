require 'test_helper'

module V1
  class IntegrationTest < ActionDispatch::IntegrationTest
    private

    def path
      assert false, 'Warning: Your test is missing the `def path`'
    end

    def headers
      assert false, 'Warning: Your test is missing the `def header`'
    end

    def test_fixture
      assert false, 'Warning: Your test is missing the `def test_fixture`'
    end

    def expected_attributes
      assert false, 'Warning: Your test is missing the `def expected_attributes`'
    end

    def expected_relationships
      assert false, 'Warning: Your test is missing the `def expected_attributes`'
    end

    def create_params
      {}
    end

    def assert_can_fetch_all(allowed, expected_amount, total_amount)
      get path, headers: headers

      if allowed
        assert_response 200
        data = JSON.parse(@response.body)['data']
        assert_equal Array, data.class
        assert_equal expected_amount, data.length, "The JSON response is an array of #{expected_amount} resources"
        assert_equal total_amount, klass.count, "The database has #{total_amount} records in total"
      else
        assert_response 403
      end
    end

    def assert_can_fetch_one_by_id(allowed)
      get "#{path}/#{test_fixture.id}", headers: headers

      if allowed
        assert_response 200
        assert_json_response
      else
        assert_response 403
      end
    end

    def assert_cannot_fetch_bogus_id
      get "#{path}/bogus-id", headers: public_header
      assert [403, 422].include?(response.code.to_i)
    end

    def assert_can_fetch_one_by_slug(allowed)
      return assert true unless test_fixture.has_attribute?('slug')

      get "#{path}/?slug=#{test_fixture.slug}", headers: headers

      if allowed
        assert_response 200
        assert_json_response
      else
        assert_response 403
      end
    end

    def assert_cannot_fetch_bogus_slug
      get "#{path}/?slug=bogus-slug", headers: headers
      assert [403, 422].include?(response.code.to_i)
    end

    def assert_json_response
      data = JSON.parse(@response.body)['data']

      assert_equal Hash, data.class, 'The response is JSON and has "data" as root key'
      refute_nil data['id'], 'The JSON response includes an ID'

      expected_attributes.each do |attr|
        key = attr.to_s.dasherize
        assert_equal test_fixture[attr].to_s, data['attributes'][key], "The JSON response has the expected attribute key & value: #{key}"
      end

      expected_relationships.each do |rel|
        key = rel.to_s.dasherize
        refute_nil data['relationships'][key], "The JSON response has the expected relationship key: #{key}"
      end

      assert_equal expected_attributes.length, data['attributes'].length, 'The JSON response has the expected amount of attributes'
      assert_equal expected_relationships.length, data['relationships'].length, 'The JSON response has the expected amount of relationships'
    end

    def assert_can_create(allowed)
      count_before = klass.count if allowed

      post path, params: create_params, headers: headers

      if allowed
        assert_response 201
        assert_json_response
        count_after = klass.count
        assert_equal count_before + 1, count_after
      else
        assert_response 403
      end
    end

    def assert_can_update(allowed)
      params = {}

      put "#{path}/#{test_fixture.id}", params: params, headers: headers

      if allowed
        assert_response 200
        # TODO
      else
        assert_response 403
      end
    end

    def assert_can_delete(allowed)
      delete "#{path}/#{test_fixture.id}", headers: headers

      if allowed
        assert_response 200
      else
        assert_response 403
      end
    end
  end
end
