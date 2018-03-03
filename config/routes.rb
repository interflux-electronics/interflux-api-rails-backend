Rails.application.routes.draw do
  namespace :admin do
    post 'login', to: 'login#authenticate'
    jsonapi_resources :products
    jsonapi_resources :product_categories
    jsonapi_resources :product_translations
    jsonapi_resources :languages
    jsonapi_resources :users
  end
  namespace :public do
    jsonapi_resources :products
    jsonapi_resources :product_categories
  end
end
