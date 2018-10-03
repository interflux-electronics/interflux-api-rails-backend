Rails.application.routes.draw do
  # Return a 404 for all other routes
  match '*catch', to: 'application#route_not_found', via: :all
end
