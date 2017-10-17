# frozen_string_literal: true

Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  namespace :admin do
    jsonapi_resources :documents
    jsonapi_resources :products
    jsonapi_resources :user, only: %i[show]
  end
  namespace :public do
    jsonapi_resources :products, only: %i[index show]
    jsonapi_resources :documents, only: %i[index show]
  end
end
