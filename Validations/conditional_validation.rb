# frozen_string_literal: true

# --------------------------- Conditional validation ----------------------------------

# -----  Using a Symbol with :if and :unless ------

class Order < ApplicationRecord
  validates :card_number, presence: true, if: :paid_with_card?

  def paid_with_card?
    payment_type == 'card'
  end
end

# ------ Using a Proc with :if and :unless ------

class Account < ApplicationRecord
  validates :password, confirmation: true,
                       unless: proc { |a| a.password.blank? }
end

# ------- Grouping Conditional validations -------

# Example:
class User < ApplicationRecord
  with_options if: :is_admin? do |admin|
    admin.validates :password, length: { minimum: 10 }
    admin.validates :email, presence: true
  end
end

# -------- Combining Validation Conditions --------

# Example:
class Computer < ApplicationRecord
  validates :mouse, presence: true,
                    if: [proc { |c| c.market.retail? }, :desktop?],
                    unless: proc { |c| c.trackpad.present? }
end
