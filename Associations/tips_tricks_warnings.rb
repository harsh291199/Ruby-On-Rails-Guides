# frozen_string_literal: true

# Here are a few things you should know to make efficient
# use of Active Record associations in your Rails applications:

# Controlling caching
# Avoiding name collisions
# Updating the schema
# Controlling association scope
# Bi-directional associations

# -------------------- Controlling Caching ------------------------

#  The cache is shared across methods. For example:

# retrieves books from the database
author.books.load

# uses the cached copy of books
author.books.size

# uses the cached copy of books
author.books.empty?

#  if you want to reload the cache,Just call reload on the association:
# retrieves books from the database
author.books.load

# uses the cached copy of books
author.books.size

# discards the cached copy of books and goes back to the database
author.books.reload.empty?

# -------------------- Updating the Schema------------------------

# --- Creating Foreign Keys for belongs_to Associations ---

# Example:
class Book < ApplicationRecord
  belongs_to :author
end

# This declaration needs to be backed up by a corresponding
# foreign key column in the books table.
# For a brand new table, the migration might look something like this:
class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.datetime   :published_at
      t.string     :book_number
      t.references :author
    end
  end
end

# Whereas for an existing table, it might look like this:
class AddAuthorToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :author
  end
end

# --- Creating Join Tables for has_and_belongs_to_many Associations ---

# If you create a has_and_belongs_to_many association,
# you need to explicitly create the joining table.

# Example:
class Assembly < ApplicationRecord
  has_and_belongs_to_many :parts
end

class Part < ApplicationRecord
  has_and_belongs_to_many :assemblies
end

# These need to be backed up by a migration to create the assemblies_parts table.
class CreateAssembliesPartsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :assemblies_parts, id: false do |t|
      t.bigint :assembly_id
      t.bigint :part_id
    end

    add_index :assemblies_parts, :assembly_id
    add_index :assemblies_parts, :part_id
  end
end

# You can also use the method create_join_table
# class CreateAssembliesPartsJoinTable < ActiveRecord::Migration[6.0]
#   def change
#     create_join_table :assemblies, :parts do |t|
#       t.index :assembly_id
#       t.index :part_id
#     end
#   end
# end

# -------------------- Controlling Association Scope ------------------------

# Example
module MyApplication
  module Business
    class Supplier < ApplicationRecord
      has_one :account
    end

    class Account < ApplicationRecord
      belongs_to :supplier
    end
  end
end

# To associate a model with a model in a different namespace,
# you must specify the complete class name in your association declaration:

module MyApplication
  module Business
    class Supplier < ApplicationRecord
      has_one :account,
              class_name: 'MyApplication::Billing::Account'
    end
  end

  module Billing
    class Account < ApplicationRecord
      belongs_to :supplier,
                 class_name: 'MyApplication::Business::Supplier'
    end
  end
end

# -------------------- Bi-directional Associations ------------------------

# It's normal for associations to work in two directions,
# requiring declaration on two different models:
class Author < ApplicationRecord
  has_many :books
end

class Book < ApplicationRecord
  belongs_to :author
end

a = Author.first
b = a.books.first

a.first_name == b.author.first_name
# true

a.first_name = 'David'
a.first_name == b.author.first_name
# true

# Active Record supports automatic identification for most associations
# with standard names. However, Active Record will not automatically
# identify bi-directional associations that contain a scope or any of
# the following options:

# :through
# :foreign_key

# Active Record provides the :inverse_of option
# so you can explicitly declare bi-directional associations:
class Author < ApplicationRecord
  has_many :books, inverse_of: 'writer'
end

class Book < ApplicationRecord
  belongs_to :writer, class_name: 'Author', foreign_key: 'author_id'
end

# By including the :inverse_of option in the has_many association declaration,
# Active Record will now recognize the bi-directional association:

a = Author.first
b = a.books.first

a.first_name == b.writer.first_name
# true

a.first_name = 'David'
a.first_name == b.writer.first_name
# true
