Rails.application.routes.draw do
  resources :product_groups
  #
  # Make the API future proof by versioning v1
  namespace :v1 do
    #
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
      resources :leads
      resources :products
    end
    #
    # Admin endpoints
    # These endpoints are meant for internal use by authenticated users such as
    # Interflux employees. These endpoints commonly allow read, create, update
    # and destroy.
    #
    # Used by:
    # https://admin.interflux.com
    #
    namespace :admin do
      # TODO
    end
  end

  # Return a 404 for all other routes
  match '*catch', to: 'application#route_not_found', via: :all
end
