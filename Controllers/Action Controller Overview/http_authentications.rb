# frozen_string_literal: true

# ----------------- HTTP Authentications---------------

# Rails comes with three built-in HTTP authentication mechanisms:

# Basic Authentication
# Digest Authentication
# Token Authentication

# ------ HTTP Basic Authentication -----------

# Example:
class AdminsController < ApplicationController
  http_basic_authenticate_with name: 'humbaba', password: '5baa61e4'
end

# ------HTTP Digest Authentication -----------

# Example:
class AdminsController < ApplicationController
  USERS = { 'lifo' => 'world' }.freeze

  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_digest do |username|
      USERS[username]
    end
  end
end

# ------HTTP Token Authentication -----------

# Example:
class PostsController < ApplicationController
  TOKEN = 'secret'

  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
    end
  end
end
