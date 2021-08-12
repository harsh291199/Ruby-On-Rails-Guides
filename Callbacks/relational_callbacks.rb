# frozen_string_literal: true

# ------------------- Relational Callbacks ----------------

# Example:
class User < ApplicationRecord
  has_many :articles, dependent: :destroy
end

# Article class
class Article < ApplicationRecord
  after_destroy :log_destroy_action

  def log_destroy_action
    puts 'Article destroyed'
  end
end

user = User.first
# => <User id: 1>

user.articles.create!
# => <Article id: 1, user_id: 1>

user.destroy
# Article destroyed
# => <User id: 1>
