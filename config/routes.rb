Rails.application.routes.draw do
  namespace :public do
    resources :products, only: [:index, :show]
    resources :documents, only: [:index]
    resources :contacts, only: [:index, :show]
  end
  namespace :admin do
    resources :products
    resources :documents
    resources :contacts
  end
end
