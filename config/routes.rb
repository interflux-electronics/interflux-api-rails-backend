# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    post 'login', to: 'login#authenticate'
    jsonapi_resources :products
    jsonapi_resources :product_groups, only: %i[index]
    jsonapi_resources :product_sub_groups, only: %i[index]
    jsonapi_resources :languages, only: %i[index]
    # jsonapi_resources :documents
    # jsonapi_resources :user, only: %i[show]
  end
  namespace :public do
    jsonapi_resources :products, only: %i[index show]
    # jsonapi_resources :documents, only: %i[index show]
  end
end
