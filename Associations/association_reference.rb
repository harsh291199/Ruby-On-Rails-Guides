# frozen_string_literal: true

# ---------------- Detailed Association Reference ----------------------

# ---------- belongs_to Association Reference ----------------------

# ------- Methods Added by belongs_to ----------------

# Example:
class Book < ApplicationRecord
  belongs_to :author
end

# association
@author = @book.author

# association=(associate)
@book.author = @author

# build_association(attributes = {})
@author = @book.build_author(author_number: 123,
                             author_name: 'John Doe')

# create_association(attributes = {})
@author = @book.create_author(author_number: 123,
                              author_name: 'John Doe')

# --------------- Options for belongs_to ----------------

# The belongs_to association supports these options:

# :autosave
# :class_name
# :counter_cache
# :dependent
# :foreign_key
# :primary_key
# :inverse_of
# :polymorphic
# :touch
# :validate
# :optional

# -------------- Scopes for belongs_to --------------------

# Example:
class Book < ApplicationRecord
  belongs_to :author, -> { where active: true }
end

# The belongs_to association supports these Scopes:

# where
# includes
# readonly
# select

# ------------- Do Any Associated Objects Exist? --------

# You can see if any associated objects exist by using the association.nil? method:

@msg = 'No author found for this book' if @book.author.nil?

# ---------- has_one Association Reference ----------------------

# Example:
class Supplier < ApplicationRecord
  has_one :account
end

# -------- Methods Added by has_one -----------

# association
# association=(associate)
# build_association(attributes = {})
# create_association(attributes = {})
# create_association!(attributes = {})
# reload_association

# --------- Options for has_one ---------------

# :as
# :autosave
# :class_name
# :dependent
# :foreign_key
# :inverse_of
# :primary_key
# :source
# :source_type
# :through
# :touch
# :validate

# --------- Scopes for has_one ---------------

# Example:
class Supplier < ApplicationRecord
  has_one :account, -> { where active: true }
end

# The has-one association supports these Scopes:

# where
# includes
# readonly
# select

# ---------- has_many Association Reference ----------------------

# Example:
class Author < ApplicationRecord
  has_many :books
end

# --------- Methods Added by has_many -----------

# collection
# collection<<(object, ...)
# collection.delete(object, ...)
# collection.destroy(object, ...)
# collection=(objects)
# collection_singular_ids
# collection_singular_ids=(ids)
# collection.clear
# collection.empty?
# collection.size
# collection.find(...)
# collection.where(...)
# collection.exists?(...)
# collection.build(attributes = {})
# collection.create(attributes = {})
# collection.create!(attributes = {})
# collection.reload

# ----------- Options for has_many --------------

# Example:
class Author < ApplicationRecord
  has_many :books, dependent: :delete_all, validate: false
end

# The has_many association supports these options:

# :as
# :autosave
# :class_name
# :counter_cache
# :dependent
# :foreign_key
# :inverse_of
# :primary_key
# :source
# :source_type
# :through
# :validate

# ------------ Scopes for has_many ---------------

# Example:
class Author < ApplicationRecord
  has_many :books, -> { where processed: true }
end

# The has_many association supports these Scopes:

# where
# extending
# group
# includes
# limit
# offset
# order
# readonly
# select
# distinct

# -------------- has_and_belongs_to_many Association Reference ----------------------

# Example:
class Part < ApplicationRecord
  has_and_belongs_to_many :assemblies
end

# ---------- Methods Added by has_and_belongs_to_many -----------------

# collection
# collection<<(object, ...)
# collection.delete(object, ...)
# collection.destroy(object, ...)
# collection=(objects)
# collection_singular_ids
# collection_singular_ids=(ids)
# collection.clear
# collection.empty?
# collection.size
# collection.find(...)
# collection.where(...)
# collection.exists?(...)
# collection.build(attributes = {})
# collection.create(attributes = {})
# collection.create!(attributes = {})
# collection.reload

# ----------- Options for has_and_belongs_to_many ---------------

# Example:
class Parts < ApplicationRecord
  has_and_belongs_to_many :assemblies, -> { readonly },
                          autosave: true
end

# The has_and_belongs_to_many association supports these options:

# :association_foreign_key
# :autosave
# :class_name
# :foreign_key
# :join_table
# :validate

# ------------ Scopes for has_and_belongs_to_many ----------------

# Example:
class Parts < ApplicationRecord
  has_and_belongs_to_many :assemblies, -> { where active: true }
end

# The has_and_belongs_to_many association supports these Scopes:

# where
# extending
# group
# includes
# limit
# offset
# order
# readonly
# select
# distinct

# ---------------------- Association Callbacks ----------------------

# There are four available association callbacks:

before_add
after_add
before_remove
after_remove

# Example:
class Author < ApplicationRecord
  has_many :books, before_add: :check_credit_limit

  def check_credit_limit(book)
    # ...
  end
end

# You can stack callbacks on a single event by passing them as an array:
class Author < ApplicationRecord
  has_many :books,
           before_add: %i[check_credit_limit calculate_shipping_charges]

  def check_credit_limit(book)
    # ...
  end

  def calculate_shipping_charges(book)
    # ...
  end
end

# ----------------------Association Extensions ----------------------

# If you have an extension that should be shared by many associations,
# you can use a named extension module.

# For example:
module FindRecentExtension
  def find_recent
    where('created_at > ?', 5.days.ago)
  end
end

class Author < ApplicationRecord
  has_many :books, -> { extending FindRecentExtension }
end

class Supplier < ApplicationRecord
  has_many :deliveries, -> { extending FindRecentExtension }
end

# ---------------------- Single Table Inheritance (STI) ----------------------

# First, let's generate the base Vehicle model:
bin/rails generate model vehicle type:string color:string price:decimal{10.2}

# For example, to generate the Car model:
bin/rails generate model car --parent=Vehicle

# The generated model will look like this:
class Car < Vehicle
end

# Creating a car will save it in the vehicles table with "Car" as the type field:
Car.create(color: 'Red', price: 10000)

# will generate the following SQL:
INSERT INTO "vehicles" ("type", "color", "price") VALUES ('Car', 'Red', 10000)
