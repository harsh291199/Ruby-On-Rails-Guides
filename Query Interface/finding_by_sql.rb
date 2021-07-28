# frozen_string_literal: true

# ------------- Finding by SQL ------------------

# Example:
Customer.find_by_sql("SELECT * FROM customers INNER JOIN orders ON
         customers.id = orders.customer_id
         ORDER BY customers.created_at desc")

# ---- select_all ----

# Example:
Customer.connection.select_all("SELECT first_name, created_at FROM customers WHERE id = '1'").to_hash

# ---- pluck ----

# Example:
Book.where(out_of_print: true).pluck(:id)

Order.distinct.pluck(:status)

Customer.pluck(:id, :first_name)

# ---- ids ----

# Example:
class Customer < ApplicationRecord
  self.primary_key = 'customer_id'
end

Customer.ids
# SELECT customer_id FROM customers

