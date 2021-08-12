# frozen_string_literal: true

# --------------------------- Common Validation Options ----------------------------------

# These are common validation options:

# -------- allow_nil --------
class Coffee < ApplicationRecord
  validates :size, inclusion: { in: %w[small medium large],
                                message: '%{value} is not a valid size' }, allow_nil: true
end

# -------- allow_blank -------
class Topic < ApplicationRecord
  validates :title, length: { is: 5 }, allow_blank: true
end

# ---------- message ------------
class Person < ApplicationRecord
  # Hard-coded message
  validates :name, presence: { message: 'must be given please' }

  validates :age, numericality: { message: '%{value} seems wrong' }

  # Proc
  validates :username,
            uniqueness: {
              message: lambda do |object, data|
                "Hey #{object.name}, #{data[:value]} is already taken."
              end
            }
end

# --------- on ----------------

# Example:
class Person < ApplicationRecord
  validates :email, uniqueness: true, on: :create
  validates :age, numericality: true, on: :update
  validates :name, presence: true
end

# Other Example:
class Person < ApplicationRecord
  validates :email, uniqueness: true, on: :account_setup
  validates :age, numericality: true, on: :account_setup
  validates :name, presence: true
end

person = Person.new
person.valid?(:account_setup)
# => false

person.errors.messages
# =>  {:email=>["has already been taken"], :age=>["is not a number"], :name=>["can't be blank"]}

# ------------------------------------ Strict Validations ----------------------------------------

# You can also specify validations to be strict and
# raise ActiveModel::StrictValidationFailed when the object is invalid.

class Person < ApplicationRecord
  validates :name, presence: { strict: true }
end

Person.new.valid?
# => ActiveModel::StrictValidationFailed: Name can't be blank

# There is also the ability to pass a custom exception to the :strict option.

class Person < ApplicationRecord
  validates :token, presence: true, uniqueness: true, strict: TokenGenerationException
end

Person.new.valid?
# => TokenGenerationException: Token can't be blank
