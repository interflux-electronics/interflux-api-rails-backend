Rails.application.routes.draw do
  resources :countries

  # Return a 404 for all other routes
  match '*catch', to: 'application#route_not_found', via: :all
end
