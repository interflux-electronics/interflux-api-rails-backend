# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    jsonapi_resources :products
  end
  namespace :public do
    jsonapi_resources :products, only: %i[index]
  end
end
