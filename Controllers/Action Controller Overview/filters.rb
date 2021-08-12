# frozen_string_literal: true

# ----------------- Topic: Filters ---------------

# Example: filter method
class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def require_login
    return if logged_in?

    flash[:error] = 'You must be logged in to access this section'
    redirect_to new_login_url
  end
end

class LoginsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
end

# -------- After Filters and Around Filters

# Example:
class ChangesController < ApplicationController
  around_action :wrap_in_transaction, only: :show

  private

  def wrap_in_transaction
    ActiveRecord::Base.transaction do
      yield
    ensure
      raise ActiveRecord::Rollback
    end
  end
end

# -------- Other Ways to Use Filters

# Example: First way
class ApplicationController < ActionController::Base
  before_action do |controller|
    unless controller.send(:logged_in?)
      flash[:error] = 'You must be logged in to access this section'
      redirect_to new_login_url
    end
  end
end

# Example: Second way
class ApplicationController < ActionController::Base
  before_action LoginFilter
end

# Login Filter class
class LoginFilter
  def self.before(controller)
    return if controller.send(:logged_in?)

    controller.flash[:error] = 'You must be logged in to access this section'
    controller.redirect_to controller.new_login_url
  end
end
