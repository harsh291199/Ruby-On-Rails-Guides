# frozen_string_literal: true

# -------------- callback registration -----------------

# Example:
class User < ApplicationRecord
  validates :login, :email, presence: true

  before_validation :ensure_login_has_a_value

  private

  def ensure_login_has_a_value
    self.login = email if login.nil? && !email.blank?
  end
end

# Example:
class User < ApplicationRecord
  validates :login, :email, presence: true

  before_create do
    self.name = login.capitalize if name.blank?
  end
end

# Example:
class User < ApplicationRecord
  before_validation :normalize_name, on: :create

  # :on takes an array as well
  after_validation :set_location, on: %i[create update]

  private

  def normalize_name
    self.name = name.downcase.titleize
  end

  def set_location
    self.location = LocationService.query(self)
  end
end


