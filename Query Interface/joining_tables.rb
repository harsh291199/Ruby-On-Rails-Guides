# frozen_string_literal: true

# ------------- Joining Tables ------------------

# ------ joins method ---------

# Example:
Author.joins("INNER JOIN books ON books.author_id = authors.id AND books.out_of_print = FALSE")

# Example:
Book.joins(:reviews)

# Example:
Book.joins(:author, :reviews)

# ------ left_outer_joins method ---------

# Example:
Customer.left_outer_joins(:reviews).distinct.select('customers.*, COUNT(reviews.*) AS reviews_count').group('customers.id')


