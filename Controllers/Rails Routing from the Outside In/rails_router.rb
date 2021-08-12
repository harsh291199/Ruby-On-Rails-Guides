# frozen_string_literal: true

# ----------------- Topic: Purpose of the Rails router ---------------

# ----- Connecting URLs to Code

# When your Rails application receives an incoming request for:
# => GET /patients/17

# it asks the router to match it to a controller action. If the first matching route is:
get '/patients/:id', to: 'patients#show'

# the request is dispatched to the patients controller's show action with { id: '17' } in params.

# ----- Generating Paths and URLs from Code

# Example:
get '/patients/:id', to: 'patients#show', as: 'patient'

# ----- Configuring the Rails Router

Rails.application.routes.draw do
  resources :brands, only: %i[index show] do
    resources :products, only: %i[index show]
  end

  resource :basket, only: %i[show update destroy]

  resolve('Basket') { route_for(:basket) }
end
