# frozen_string_literal: true

# ------------- Retrieving a Single Object ------------------

# --- find method ---
# Example:
customer = Customer.find(10)

# --- take method ---
# Example:
customer = Customer.take
customer = Customer.take(5)

# --- first method ---
# Example:
customer = Customer.first
customers = Customer.first(3)

# --- last method ---
# Example:
customer = Customer.last
customers = Customer.last(3)

# --- find_by method ---
# Example:
Customer.find_by first_name: 'Harsh'
Customer.find_by first_name: 'Yash'

# ------------- Retrieving Multiple Objects in Batches ------------------

# --- find_each method ---
# Example:
Customer.find_each do |customer|
  NewsMailer.weekly(customer).deliver_now
end

# --- find_in_batches method ---
# Example:
Customer.find_in_batches do |customers|
  export.add_customers(customers)
end



