# frozen_string_literal: true

# ------------- Locking Records for update ------------------

# ----- Optimistic Locking -----

# Example:
c1 = Customer.find(1)
c2 = Customer.find(1)

c1.first_name = 'Sandra'
c1.save

c2.first_name = 'Michael'
c2.save # Raises an ActiveRecord::StaleObjectError

# locking_column class attribute
class Customer < ApplicationRecord
  self.locking_column = :lock_customer_column
end

# ----- Pessimistic Locking -----

# Example:

Book.transaction do
  book = Book.lock.first
  book.title = 'Algorithms, second edition'
  book.save!
end
