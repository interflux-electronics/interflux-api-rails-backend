Rails.application.routes.draw do
  # Make the API future proof by versioning v1
  namespace :v1 do
    # Public endpoints
    # These endpoints are meant for the public. No sensitive information is ever
    # made available here. Initially these endpoints will be consumed by our
    # public facing websites, but we anticipate and allow also third parties,
    # such as scrapers and bots, to read from them.
    #
    # Used by:
    # https://www.interflux.com
    # https://lmpa.interflux.com
    #
    namespace :public do
      resources :articles
      resources :containers
      resources :countries
      resources :features
      resources :images
      resources :leads
      resources :product_families, path: '/product-families'
      resources :product_features, path: '/product-features'
      resources :product_images, path: '/product-images'
      resources :product_uses, path: '/product-uses'
      resources :product_variants, path: '/product-variants'
      resources :product_videos, path: '/product-videos'
      resources :products
      resources :uses
      resources :videos
    end

    # Admin endpoints
    # These endpoints are meant for internal use by authenticated users such as
    # Interflux employees. These endpoints commonly allow read, create, update
    # and destroy.
    #
    # Used by:
    # https://admin.interflux.com
    #
    namespace :admin do
      # resources :article_tags, path: '/article-tags'
      # resources :articles
      resources :companies
      # resources :company_members, path: '/company-members'
      # resources :company_markets, path: '/company-markets'
      # resources :containers
      # resources :countries
      # resources :country_currencies, path: '/country-currencies'
      # resources :country_languages, path: '/country-languages'
      # resources :currencies
      resources :documents
      resources :document_categories, path: '/document-categories'
      # resources :employees
      # resources :features
      resources :images
      resources :languages
      # resources :leads
      resources :people
      # resources :product_complements, path: '/product-complements'
      resources :product_documents, path: '/product-documents'
      resources :product_families, path: '/product-families'
      # resources :product_features, path: '/product-features'
      resources :product_images, path: '/product-images'
      # resources :product_related_articles, path: '/product-related-articles'
      resources :products, path: '/products'
      # resources :product_substitutes, path: '/product-substitutes'
      # resources :product_variants, path: '/product-variants'
      # resources :tags
      resources :users

      # All none-CRUD request regarding authentication:
      # POST /v1/admin/verify_email { email }
      # POST /v1/admin/verify_password { email, password }
      # POST /v1/admin/get_auth_user { token }
      # POST /v1/admin/verify_extend_expiry { token }
      # POST /v1/admin/verify_logout { token }
      post '/auth/verify-email', to: 'authentication#verify_email'
      post '/auth/verify-password', to: 'authentication#verify_password'
      # get '/auth/user', to: 'authentication#get_auth_user'
      # post '/extend_expiry', to: 'authentication#extend_expiry'
      # post '/logout', to: 'authentication#logout'
    end
  end

  # Return app meta info for health check.
  get 'sanity-check', to: 'sanity#check'

  # Return a 404 for all other routes.
  match '*catch', to: 'application#render_404', via: :all
end
