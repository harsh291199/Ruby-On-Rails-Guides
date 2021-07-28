# frozen_string_literal: true

# ------------- Scopes ------------------

# Example:
class Book < ApplicationRecord
  scope :out_of_print, -> { where(out_of_print: true) }
end

Book.out_of_print
# <ActiveRecord::Relation> # all out of print books

# ------ Passing in arguments -----

# Example:
class Book < ApplicationRecord
  scope :costs_more_than, ->(amount) { where('price > ?', amount) }
end

Book.costs_more_than(100.10)

# ------ Using conditionals -----

# Example:
class Order < ApplicationRecord
  scope :created_before, ->(time) { where('created_at < ?', time) if time.present? }
end

# ------ Applying a default scope -----

# Example:
class Book < ApplicationRecord
  default_scope { where(out_of_print: false) }
end

Book.new
# => #<Book id: nil, out_of_print: nil>

# ------ Merging of scopes -----

# Example:
class Book < ApplicationRecord
  scope :in_print, -> { where(out_of_print: false) }
  scope :out_of_print, -> { where(out_of_print: true) }

  scope :recent, -> { where('year_published >= ?', Date.current.year - 50) }
  scope :old, -> { where('year_published < ?', Date.current.year - 50) }
end

Book.out_of_print.old
# SELECT books.* FROM books WHERE books.out_of_print = 'true' AND books.year_published < 1969

# ------ Removing All Scoping -----

# Example:
Book.unscoped.load

# Example: unscoped with accepting block
Book.unscoped { Book.out_of_print }