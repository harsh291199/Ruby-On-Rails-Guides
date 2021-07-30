# frozen_string_literal: true

# ----------------- Topic: Sessions ---------------

# Session can use one of a number of different storage mechanisms:

# ActionDispatch::Session::CookieStore
# ActionDispatch::Session::CacheStore
# ActionDispatch::Session::ActiveRecordStore
# ActionDispatch::Session::MemCacheStore

# Example:
Rails.application.config.session_store :cookie_store, key: '_your_app_session'

# with domain name
Rails.application.config.session_store :cookie_store, key: '_your_app_session', domain: '.example.com'

# ----------- Accessing the Session ---------

# Example:

# Access session in Application Controller
class ApplicationController < ActionController::Base
  private

  def current_user
    @current_user ||= session[:current_user_id] &&
                      User.find_by(id: session[:current_user_id])
  end
end

# Store something in session
class LoginsController < ApplicationController
  def create
    return unless user == User.authenticate(params[:username], params[:password])

    session[:current_user_id] = user.id
    redirect_to root_url
  end
end

# Remove something from the session
class LoginsController < ApplicationController
  def destroy
    session.delete(:current_user_id)
    @current_user = nil
    redirect_to root_url
  end
end

# ----------- The Flash ---------

# Example:
class LoginsController < ApplicationController
  def destroy
    session.delete(:current_user_id)
    flash[:notice] = 'You have successfully logged out.'
    redirect_to root_url
  end
end

# flash.keep
class MainController < ApplicationController
  def index
    flash.keep
    redirect_to users_url
  end
end

# flash.now
class ClientsController < ApplicationController
  def create
    @client = Client.new(client_params)
    if @client.save
      # ...
    else
      flash.now[:error] = 'Could not save client'
      render action: 'new'
    end
  end
end
