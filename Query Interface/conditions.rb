# frozen_string_literal: true

# ------------- Conditions ------------------

# ---- Pure String Conditions ----

# Example:
Book.where("title = 'Introduction to Algorithms'")

# ---- Array Conditions ----

# Example:
Book.where('title = ?', params[:title])
# or
Book.where("title = #{params[:title]}")

# ---- Hash Conditions ----

# Example:
Book.where('out_of_print' => true)

Book.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)

Customer.where(orders_count: [1, 3, 5])

# ---- NOT Conditions ----

# Example:
Customer.where.not(orders_count: [1, 3, 5])

# ---- OR Conditions ----

# Example:
Customer.where(last_name: 'Smith').or(Customer.where(orders_count: [1, 3, 5]))


