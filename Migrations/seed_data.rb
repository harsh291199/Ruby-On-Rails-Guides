# frozen_string_literal: true

# Migrations can also be used to add or modify data.
# This is useful in an existing database that can't be destroyed and recreated, such as a production database.

# class
class AddInitialProducts < ActiveRecord::Migration[6.0]
  def up
    5.times do |i|
      Product.create(name: "Product ##{i}", description: 'A product.')
    end
  end

  def down
    Product.delete_all
  end
end
