# frozen_string_literal: true

# ----------------- Topic: Non-Resourceful Routes ---------------

# ----- Bound Parameters

# Example:
get 'photos(/:id)', to: 'photos#display'

# ----- Dynamic Segments

# Example:
get 'photos/:id/:user_id', to: 'photos#show'

# ----- Static Segments

# Example:
get 'photos/:id/with_user/:user_id', to: 'photos#show'

# ----- The Query String

# Example:
get 'photos/:id', to: 'photos#show'

# ----- Defining Defaults

# Example:
get 'photos/:id', to: 'photos#show', defaults: { format: 'jpg' }

# ----- Naming Routes

# Example:
get 'exit', to: 'sessions#destroy', as: :logout

# ----- HTTP Verb Constraints

# Example:
match 'photos', to: 'photos#show', via: %i[get post]
# OR
match 'photos', to: 'photos#show', via: :all

# ----- Segment Constraints

# Example:
get 'photos/:id', to: 'photos#show', constraints: { id: /[A-Z]\d{5}/ }

# ----- Request-Based Constraints

# Example:
get 'photos', to: 'photos#index', constraints: { subdomain: 'admin' }

# ----- Advanced Constraints

# Example:
class RestrictedListConstraint
  def initialize
    @ips = RestrictedList.retrieve_ips
  end

  def matches?(request)
    @ips.include?(request.remote_ip)
  end
end

Rails.application.routes.draw do
  get '*path', to: 'restricted_list#index',
               constraints: RestrictedListConstraint.new
end
# OR
Rails.application.routes.draw do
  get '*path', to: 'restricted_list#index',
               constraints: ->(request) { RestrictedList.retrieve_ips.include?(request.remote_ip) }
end

# ----- Route Globbing and Wildcard Segments

# Example:
get 'photos/*other', to: 'photos#unknown'
# Another example:
get 'books/*section/:title', to: 'books#show'

# ----- Redirection

# Example:
get '/stories', to: redirect('/articles')
# Another example:
get '/stories/:name', to: redirect('/articles/%<name>')

# ----- Routing to Rack Applications

# Example:
match '/application.js', to: MyRackApp, via: :all

# ----- Using root

# Example:
root to: 'pages#main'
# OR
root 'pages#main'

# ----- Direct Routes

# Example:
direct :homepage do
  'http://www.rubyonrails.org'
end

# ----- Using resolve

# Example:
resource :basket

resolve('Basket') { [:basket] }
