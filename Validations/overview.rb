# frozen_string_literal: true

# ---------------------------- Overview of Validations -----------------------------------

# Here's an example of a very simple validation:
class Person < ApplicationRecord
  validates :name, presence: true
end

Person.create(name: 'John Doe').valid?
# => true

Person.create(name: nil).valid?
# => false

# The following methods trigger validations, and will save the object
# to the database only if the object is valid:

# create
# create!
# save
# save!
# update
# update!

# ------------- valid? method -------------------------------
# Before saving an Active Record object, Rails runs your validations.
# If these validations produce any errors, Rails does not save the object.

class Person < ApplicationRecord
  validates :name, presence: true
end

Person.create(name: 'John Doe').valid?
# => true

Person.create(name: nil).valid?
# => false

# ------------------ errors instance method -----------------------------
# After Active Record has performed validations,
# any errors found can be accessed through the errors instance method, which returns a collection of errors.

class Person < ApplicationRecord
  validates :name, presence: true
end

# new method
p = Person.new
# => #<Person id: nil, name: nil>
p.errors.size
# 0
p.valid?
# =>false
p.errors.objects.first.full_message
# => "Name can't be blank"

# create method
p = Person.create
# => #<Person id: nil, name: nil>
p.errors.objects.first.full_message
# => "Name can't be blank"

# -----------------  errors[] method --------------------------------

# To verify whether or not a particular attribute of an object is valid,
# you can use errors[:attribute].

# Example:
class Person < ApplicationRecord
  validates :name, presence: true
end

Person.new.errors[:name].any?
# => false

Person.create.errors[:name].any?
# => true
