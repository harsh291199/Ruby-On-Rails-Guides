# frozen_string_literal: true

# ------------- Method Chaining ------------------

# ---- Retrieving filtered data from multiple tables ----

# Example:
Customer
  .select('customers.id, customers.last_name, reviews.body')
  .joins(:reviews)
  .where('reviews.created_at > ?', 1.week.ago)

# ----  Retrieving specific data from multiple tables ----

# Example:
Book
  .select('books.id, books.title, authors.first_name')
  .joins(:author)
  .find_by(title: 'Abstraction and Specification in Program Development')
