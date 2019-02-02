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
      resources :countries
      resources :languages
      resources :leads
      resources :product_groups, path: '/product-groups'
      resources :product_translations, path: '/product-translations'
      resources :products
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
      resources :article_tags, path: '/article-tags'
      resources :articles
      resources :companies
      resources :countries
      resources :documents
      resources :images
      resources :languages
      resources :leads
      resources :people
      resources :person
      resources :product_documents, path: '/product-documents'
      resources :product_features, path: '/product-features'
      resources :product_groups, path: '/product-groups'
      resources :product_images, path: '/product-images'
      resources :product_related_articles, path: '/product-related-articles'
      resources :product_related_products, path: '/product-related-products'
      resources :product_variations, path: '/product-variations'
      resources :products
    end
  end

  # Return app meta info for health check.
  get 'status', to: 'application#status'

  # Return a 404 for all other routes.
  match '*catch', to: 'application#route_not_found', via: :all
end
