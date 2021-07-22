# frozen_string_literal: true

# ---------------------------- Custom Validations -------------------------------------

# When the built-in validation helpers are not enough for your needs,
# you can write your own validators or validation methods as you prefer.

# --------------- Custom Validators ----------------------

# Example:
class MyValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :name, 'Need a name starting with X please!' unless record.name.start_with? 'X'
  end
end

class Person
  include ActiveModel::Validations
  validates_with MyValidator
end

# ---------------- Custom Methos ----------------------

# Example:
class Invoice < ApplicationRecord
  validate :expiration_date_cannot_be_in_the_past,
           :discount_cannot_be_greater_than_total_value

  def expiration_date_cannot_be_in_the_past
    errors.add(:expiration_date, "can't be in the past") if expiration_date.present? && expiration_date < Date.today
  end

  def discount_cannot_be_greater_than_total_value
    errors.add(:discount, "can't be greater than total value") if discount > total_value
  end
end
