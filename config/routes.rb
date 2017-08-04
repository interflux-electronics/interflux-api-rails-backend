# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :public do
    resources :products, only: %i[index show]
    resources :documents, only: [:index]
    resources :contacts, only: %i[index show]
  end
  namespace :admin do
    resources :products
    resources :documents
    resources :contacts
  end
end
