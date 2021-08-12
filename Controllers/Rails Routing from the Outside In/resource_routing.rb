# frozen_string_literal: true

# ----------------- Topic: Resource Routing: the Rails Default ---------------

# ----- Resources on the Web

# Example:
resources :photos
# and
resources :articles

# ----- Path and URL Helpers

# photos_path returns /photos
# new_photo_path returns /photos/new
# edit_photo_path(:id) returns /photos/:id/edit
# photo_path(:id) returns /photos/:id

# ----- Defining Multiple Resources at the Same Time

# Example:
resources :photos, :books, :videos
# OR
resources :photos
resources :books
resources :videos

# ----- Singular Resources

# Example:
get 'profile', action: :show, controller: 'users'

resource :geocoder
resolve('Geocoder') { [:geocoder] }

# ----- Controller Namespaces and Routing

# Example:
namespace :admin do
  resources :articles, :comments
end

# ------ Nested Resources

# Example: If we have included these models in our application
class Magazine < ApplicationRecord
  has_many :ads
end

class Ad < ApplicationRecord
  belongs_to :magazine
end

# Then,we can write nested resources like:
resources :magazines do
  resources :ads
end

# Another Example:
resources :publishers do
  resources :magazines do
    resources :photos
  end
end

# ------ Routing Concerns

# Example:
concern :commentable do
  resources :comments
end

concern :image_attachable do
  resources :images, only: :index
end

# ------ Creating Paths and URLs from Objects

# If we have this set of routes:
resources :magazines do
  resources :ads
end

# Then, we can use magazine_ad_path like this:
# <%= link_to 'Ad details', magazine_ad_path(@magazine, @ad) %>

# We can add url_for also:
# <%= link_to 'Ad details', url_for([@magazine, @ad]) %>

# ------ Adding More RESTful Actions

# Example: Member Routes
resources :photos do
  member do
    get 'preview'
  end
end

# Example: Collection Routes
resources :photos do
  collection do
    get 'search'
  end
end

# Example: Routes for Additional New Actions
resources :comments do
  get 'preview', on: :new
end
