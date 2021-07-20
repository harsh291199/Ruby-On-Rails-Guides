# frozen_string_literal: true

# Migrations are stored as files in the db/migrate directory, one for each migration class.
# The name of the file is of the form YYYYMMDDHHMMSS_create_products.rb

# ------------------------ Topic-1 : Creating a Standalone Migration ------------------------------------------

bin/rails generate migration AddPartNumberToProducts

# This will create an appropriately named empty migration:

class AddPartNumberToProducts < ActiveRecord::Migration[6.0]
  def change; end
end

# If the migration name is of the form "AddColumnToTable" or "RemoveColumnFromTable"
# and is followed by a list of column names and types then a migration containing the
# appropriate add_column and remove_column statements will be created.

bin/rails generate migration AddPartNumberToProducts part_number:string

# will generate

class AddPartNumberToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :part_number, :string
  end
end

# If you'd like to add an index on the new column, you can do that as well.

bin/rails generate migration AddPartNumberToProducts part_number:string:index

# will generate the appropriate add_column and add_index statements:

class AddPartNumberToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :part_number, :string
    add_index :products, :part_number
  end
end

# Similarly, you can generate a migration to remove a column from the command line:

bin/rails generate migration RemovePartNumberFromProducts part_number:string

# generates

class RemovePartNumberFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :part_number, :string
  end
end

# You are not limited to one magically generated column. For example:

bin/rails generate migration AddDetailsToProducts part_number:string price:decimal

# generates

class AddDetailsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :part_number, :string
    add_column :products, :price, :decimal
  end
end

# Also, the generator accepts column type as references (also available as belongs_to).
# For example,

bin/rails generate migration AddUserRefToProducts user:references

# generates the following add_reference call:

class AddUserRefToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :user, foreign_key: true
  end
end

# There is also a generator which will produce join tables if JoinTable is part of the name:

bin/rails generate migration CreateJoinTableCustomerProduct customer product

# will produce the following migration:

class CreateJoinTableCustomerProduct < ActiveRecord::Migration[6.0]
  def change
    create_join_table :customers, :products do |t|
      # t.index [:customer_id, :product_id]
      # t.index [:product_id, :customer_id]
    end
  end
end

# ------------------------------ Topic-2 : Model Generators ------------------------------------------

# If you tell Rails what columns you want, then statements for adding these columns will also be created.
# For example,

bin/rails generate model Product name:string description:text

# will create a migration that looks like this

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

# ------------------------------ Topic-3 : Passing Modifiers ------------------------------------------

# Some commonly used type modifiers can be passed directly on the command line.
# They are enclosed by curly braces and follow the field type:

# For instance, running:
bin/rails generate migration AddDetailsToProducts 'price:decimal{5,2}' supplier:references{polymorphic}

# will produce a migration that looks like this

class AddDetailsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :price, :decimal, precision: 5, scale: 2
    add_reference :products, :supplier, polymorphic: true
  end
end
