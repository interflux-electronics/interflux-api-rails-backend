Rails.application.routes.draw do
  # For the public:
  # https://www.interflux.com
  # https://lmpa.interflux.com
  namespace :public do
    resources :products
    resources :product_categories, path: '/product-categories'
    resources :product_features, path: '/product-features'
    resources :product_uses, path: '/product-uses'
    resources :translations
    resources :uses
  end

  # For authenticated admins:
  # https://admin.interflux.com
  namespace :admin do
    post 'login', to: 'login#authenticate'
    resources :features
    resources :images
    resources :languages
    resources :product_categories, path: '/product-categories'
    resources :product_features, path: '/product-features'
    resources :product_images, path: '/product-images'
    resources :product_translations, path: '/product-translations'
    resources :product_uses, path: '/product-uses'
    resources :products
    resources :users
  end

  # Return a 403 forbidden for :all.
  # Avoid adding `only: [:index, :show]` which drops request without further info for the front-end.
  # Instead this API defaults to returning a 403 forbidden unless overwritten.
  # See application controller.

  # Return a 404 for all other routes
  match '*catch', to: 'application#route_not_found', via: :all
end
