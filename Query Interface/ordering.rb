# frozen_string_literal: true

# ------------- Ordering ------------------

# Example:
Customer.order(:created_at)
# OR
Customer.order('created_at')

# Example: with asc & desc
Customer.order(created_at: :desc)
# OR
Customer.order(created_at: :asc)
# OR
Customer.order('created_at DESC')
# OR
Customer.order('created_at ASC')

# Example: Ordering by multiple fields
Customer.order(orders_count: :asc, created_at: :desc)
# OR
Customer.order(:orders_count, created_at: :desc)
# OR
Customer.order('orders_count ASC, created_at DESC')
# OR
Customer.order('orders_count ASC', 'created_at DESC')
