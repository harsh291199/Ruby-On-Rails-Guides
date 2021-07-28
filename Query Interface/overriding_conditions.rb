# frozen_string_literal: true

# ------------- Overriding Conditions ------------------

# ---- unscope ----

# Example:
Book.where('id > 100').limit(20).order('id desc').unscope(:order)

Book.where(id: 10, out_of_print: false).unscope(where: :id)

# ---- only ----

# Example:
Book.where('id > 10').limit(20).order('id desc').only(:order, :where)

# ---- reselect ----

# Example:
Book.select(:title, :isbn).reselect(:created_at)

# ---- reorder ----

# Example:
class Author < ApplicationRecord
  has_many :books, -> { order(year_published: :desc) }
end

Author.find(10).books.reorder('year_published ASC')

# ---- reverse order ----

# Example:
Customer.where('orders_count > 10').order(:last_name).reverse_order

# ---- rewhere ----

# Example:
Book.where(out_of_print: true).rewhere(out_of_print: false)