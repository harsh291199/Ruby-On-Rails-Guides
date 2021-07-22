# frozen_string_literal: true

# ----------------------------- Validation Errors ------------------------------

# ------------- errors ----------------

# Example:
class Person < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
end

person = Person.new
person.errors.full_messages
# => ["Name can't be blank", "Name is too short (minimum is 3 characters)"]

# ------------- errors[] ----------------

# Example:
class Person < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
end

person = Person.new

person.errors[:name]
# => ["can't be blank", "is too short (minimum is 3 characters)"]

# -------------errors.where and error object ----------------

# Example:
class Person < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
end

person = Person.new

person.errors.where(:name)
# => [ ... ] # all errors for :name attribute

person.errors.where(:name, :too_short)
# => [ ... ] # :too_short errors for :name attribute

# ------------ errors.add ----------------

# Example:
class Person < ApplicationRecord
  validate do |_person|
    errors.add :name, :too_plain, message: 'is not cool enough'
  end
end

person = Person.create

person.errors.where(:name).first.type
# => :too_plain

person.errors.where(:name).first.full_message
# => "Name is not cool enough"

# ------------ errors[:base] ----------------

# Example:
class Person < ApplicationRecord
  validate do |_person|
    errors.add :base, :invalid, message: 'This person is invalid because ...'
  end
end

person = Person.create
person.errors.where(:base).first.full_message
# => "This person is invalid because ..."

# ------------------- errors.clear -------------------

# Example:
class Person < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
end

person = Person.new
person.errors.empty?
# => false

person.errors.clear
person.errors.empty?
# => true

# -------------------- errors.size -------------------

# Example:
class Person < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
end

person = Person.new
person.valid?
# => false
person.errors.size
# => 2
