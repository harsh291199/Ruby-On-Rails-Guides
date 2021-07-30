# frozen_string_literal: true

# ----------------- Topic: Customizing Resourceful Routes ---------------

# ---- Specifying a Controller to Use

# Example:
resources :photos, controller: 'images'

# ----  Specifying Constraints

# Example:
resources :photos, constraints: { id: /[A-Z][A-Z][0-9]+/ }

# ---- Overriding the Named Route Helpers

# Example:
resources :photos, as: 'images'

# ---- Overriding the new and edit Segments

# Example:
resources :photos, path_names: { new: 'make', edit: 'change' }

# ----  Prefixing the Named Route Helpers

# Example:
scope 'admin' do
  resources :photos, as: 'admin_photos'
end

resources :photos

# ---- Restricting the Routes Created

# Example:
resources :photos, only: %i[index show]

resources :photos, except: :destroy

# ---- Translated Paths

# Example:
scope(path_names: { new: 'neu', edit: 'bearbeiten' }) do
  resources :categories, path: 'kategorien'
end

# ---- Overriding the Singular Form

# Example:
ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'tooth', 'teeth'
end

# ---- Using :as in Nested Resources

# Example:
resources :magazines do
  resources :ads, as: 'periodical_ads'
end

# ---- Overriding Named Route Parameters

# Example:
resources :videos, param: :identifier
