# frozen_string_literal: true

# ----------------- Available Callbacks ----------------

# -------- Creating an Object ----------

# -------- before_validation

# Example:
class Person
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attr_accessor :name

  validates_length_of :name, maximum: 6

  before_validation :remove_whitespaces

  private

  def remove_whitespaces
    name.strip!
  end
end

# -------- after_validation

# Example:
class Person
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attr_accessor :name, :status

  validates_presence_of :name

  after_validation :set_status

  private

  def set_status
    self.status = errors.empty?
  end
end

# before_save

# around_save

# before_create

# around_create

# after_create

# after_save

# after_commit
after_commit :do_foo, on: :create
after_commit :do_bar, on: :update
after_commit :do_baz, on: :destroy

after_commit :do_foo_bar, on: %i[create update]
after_commit :do_bar_baz, on: %i[update destroy]

# after_rollback

# --------------- Updating an Object ------------

# before_validation
# after_validation
# before_save
# around_save
# before_update
# around_update
# after_update
# after_save
# after_commit
# after_rollback

# -------------- Destroying an object -----------

# before_destroy
# around_destroy
# after_destroy
# after_commit
# after_rollback

# --------------- after_initialize and after_find ----------

# Example:
class User < ApplicationRecord
  after_initialize do |_user|
    puts 'You have initialized an object!'
  end

  after_find do |_user|
    puts 'You have found an object!'
  end
end

User.new
# You have initialized an object!
# => <User id: nil>

User.first
# You have found an object!
# You have initialized an object!
# => <User id: 1>

# -------------- after_touch -----------

# Example:
class User < ApplicationRecord
  after_touch do |_user|
    puts 'You have touched an object'
  end
end

u = User.create(name: 'Kuldeep')
# => <User id: 1, name: "Kuldeep", created_at: "2013-11-25 12:17:49", updated_at: "2013-11-25 12:17:49">

u.touch
# You have touched an object
# => true

# ---------------------- Running Callbacks -------------------------

# The following methods trigger callbacks:

# create
# create!
# destroy
# destroy!
# destroy_all
# destroy_by
# save
# save!
# save(validate: false)
# toggle!
# touch
# update_attribute
# update
# update!
# valid?

# ---------------------- Skipping Callbacks -------------------------

# decrement!
# decrement_counter
# delete
# delete_all
# delete_by
# increment!
# increment_counter
# insert
# insert!
# insert_all
# insert_all!
# touch_all
# update_column
# update_columns
# update_all
# update_counters
# upsert
# upsert_all

# ------------------------- Halting Execution ------------------

# The whole callback chain is wrapped in a transaction.
# If any callback raises an exception,
# he execution chain gets halted and a ROLLBACK is issued.
# To intentionally stop a chain use:

throw :abort
