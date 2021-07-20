# frozen_string_literal: true

# Migrations are a convenient way to alter your database schema over time in a consistent way.

# Example of a migration:
# This migration adds a table called products with a
# string column called name and a text column called description.

# class Createproducts
class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

# If you wish for a migration to do something that Active Record doesn't know
# how to reverse, you can use reversible:

# class ChangeProductsPrice
class ChangeProductsPrice < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :products do |t|
        dir.up   { t.change :price, :string }
        dir.down { t.change :price, :integer }
      end
    end
  end
end

# Alternatively, you can use up and down instead of change:

# class ChangeProductsPrice
class ChangeProductsPrice < ActiveRecord::Migration[6.0]
  def up
    change_table :products do |t|
      t.change :price, :string
    end
  end

  def down
    change_table :products do |t|
      t.change :price, :integer
    end
  end
end
