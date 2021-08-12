# frozen_string_literal: true

# ------------- Enums ------------------

# Example:
class Order < ApplicationRecord
  enum status: %i[shipped being_packaged complete cancelled]
end

Order.shipped
# => #<ActiveRecord::Relation> # all orders with status == :shipped

Order.not_shipped
# => #<ActiveRecord::Relation> # all orders with status != :shipped

order = Order.shipped.first
order.shipped?
# => true

order.complete?
# => false
