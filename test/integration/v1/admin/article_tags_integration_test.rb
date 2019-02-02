require 'test_helper'

module V1
  module Admin
    class ArticleTagIntegrationTest < ApplicationController
      # Public users should be able to fetch all article tags
      test '1' do
        assert_can_fetch_all true, 5, 6
      end

      # Public users should be able to fetch one article tag by ID
      test '2' do
        assert_can_fetch_one_by_id true
      end

      # Public users should be able to fetch one article tag by slug
      test '3' do
        assert_can_fetch_one_by_slug true
      end

      # Public users should NOT be able to create article tags
      test '4' do
        assert_can_create false
      end

      # Public users should NOT be able to update article tags
      test '5' do
        assert_can_update false
      end

      # Public users should NOT be able to delete article tags
      test '6' do
        assert_can_delete false
      end

      # Fetching bogus IDs should return 404
      test '7' do
        assert_cannot_fetch_bogus_id
      end

      # Fetching bogus slugs should return 404
      test '8' do
        assert_cannot_fetch_bogus_slug
      end

      private

      def klass
        ArticleTag
      end

      def path
        '/v1/admin/article_tags'
      end

      def headers
        admin_header
      end

      def test_fixture
        article_tags('article_tag_fixture_1')
      end

      def expected_attributes
        %i[
          slug
          name
          pitch
        ]
      end

      def expected_relationships
        # %i[
        #   main_group
        #   sub_group
        #   related_products
        #   related_articles
        #   translations
        # ]
      end
    end
  end
end
