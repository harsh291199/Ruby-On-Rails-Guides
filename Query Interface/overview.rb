# frozen_string_literal: true

# Example: Rails Active Record Query Bookstore

# Author of books
class Author < ApplicationRecord
  has_many :books, -> { order(year_published: :desc) }
end

# Books
class Book < ApplicationRecord
  belongs_to :supplier
  belongs_to :author
  has_many :reviews
  has_and_belongs_to_many :orders, join_table: 'books_orders'

  scope :in_print, -> { where(out_of_print: false) }
  scope :out_of_print, -> { where(out_of_print: true) }
  scope :old, -> { where('year_published < ?', 50.years.ago) }
  scope :out_of_print_and_expensive, -> { out_of_print.where('price > 500') }
  scope :costs_more_than, ->(amount) { where('price > ?', amount) }
end

# Customer
class Customer < ApplicationRecord
  has_many :orders
  has_many :reviews
end

# Order of the books
class Order < ApplicationRecord
  belongs_to :customer
  has_and_belongs_to_many :books, join_table: 'books_orders'

  enum status: %i[shipped being_packed complete cancelled]

  scope :created_before, ->(time) { where('created_at < ?', time) }
end

# Review of the book
class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :book

  enum state: %i[not_reviewed published hidden]
end

# Supplier of the books
class Supplier < ApplicationRecord
  has_many :books
  has_many :authors, through: :books
end
