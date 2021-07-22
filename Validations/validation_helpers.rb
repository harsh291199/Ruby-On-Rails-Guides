# frozen_string_literal: true

# --------------------------- Validation helpers ----------------------------------

# Active Record offers many pre-defined validation helpers that you can use directly inside your class definitions.

# Validation helpers are listed below:

# ------- acceptance --------

# Example:
class Person < ApplicationRecord
  validates :terms_of_service, acceptance: true
end

class Person < ApplicationRecord
  validates :terms_of_service, acceptance: { message: 'must be abided' }
end

class Person < ApplicationRecord
  validates :terms_of_service, acceptance: { accept: 'yes' }
  validates :eula, acceptance: { accept: %w[TRUE accepted] }
end

# ------- validates_associated --------

class Library < ApplicationRecord
  has_many :books
  validates_associated :books
end

# ------- confirmation ------------

class Person < ApplicationRecord
  validates :email, confirmation: true
end

class Person < ApplicationRecord
  validates :email, confirmation: { case_sensitive: false }
end

# -------  exclusion ------------

class Account < ApplicationRecord
  validates :subdomain, exclusion: { in: %w[www us ca jp],
                                     message: '%{value} is reserved.' }
end

# ---------- format ------------

class Product < ApplicationRecord
  validates :legacy_code, format: { with: /\A[a-zA-Z]+\z/,
                                    message: 'only allows letters' }
end

# ------------ inclusion -------------

class Coffee < ApplicationRecord
  validates :size, inclusion: { in: %w[small medium large],
                                message: '%{value} is not a valid size' }
end

# ------------- length ---------------

class Person < ApplicationRecord
  validates :name, length: { minimum: 2 }
  validates :bio, length: { maximum: 500 }
  validates :password, length: { in: 6..20 }
  validates :registration_number, length: { is: 6 }
end

# You can customize error messages like this
class Person < ApplicationRecord
  validates :bio, length: { maximum: 1000,
                            too_long: '%{count} characters is the maximum allowed' }
end

# -------------- numericality-----------------

class Player < ApplicationRecord
  validates :points, numericality: true
  validates :games_played, numericality: { only_integer: true }
end

# --------------- presence --------------------

# Example:
class Person < ApplicationRecord
  validates :name, :login, :email, presence: true
end

class Supplier < ApplicationRecord
  has_one :account
  validates :account, presence: true
end

# If you want to validate the presence of a boolean field you should use one of the following validations:
validates :boolean_field_name, inclusion: [true, false]
validates :boolean_field_name, exclusion: [nil]

# ------------------ absence -------------------

class Person < ApplicationRecord
  validates :name, :login, :email, absence: true
end

# For the Associations:
class LineItem < ApplicationRecord
  belongs_to :order
  validates :order, absence: true
end

# ------------------ uniqueness ----------------

# Example:
class Account < ApplicationRecord
  validates :email, uniqueness: true
end

class Holiday < ApplicationRecord
  validates :name, uniqueness: { scope: :year,
                                 message: 'should happen once per year' }
end

class Person < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }
end

# ----------------- validates_with -----------------

# Example:
class GoodnessValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :base, 'This person is evil' if record.first_name == 'Evil'
  end
end

class Person < ApplicationRecord
  validates_with GoodnessValidator
end

# Example with if
class GoodnessValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :base, 'This person is evil' if options[:fields].any? { |field| record.send(field) == 'Evil' }
  end
end

class Person < ApplicationRecord
  validates_with GoodnessValidator, fields: %i[first_name last_name]
end

# ----------------- validates_each -----------------

class Person < ApplicationRecord
  validates_each :name, :surname do |record, attr, value|
    record.errors.add(attr, 'must start with upper case') if value =~ /\A[[:lower:]]/
  end
end
