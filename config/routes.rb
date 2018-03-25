Rails.application.routes.draw do
  namespace :admin do
    post 'login', to: 'login#authenticate'
    resources :languages
    resources :product_categories, path: '/product-categories'
    resources :product_images, path: '/product-images'
    resources :product_translations, path: '/product-translations'
    resources :products
    resources :users
  end
  namespace :public do
    resources :products
    resources :product_categories
  end
  match '*catch', to: 'application#route_not_found', via: :all
end
