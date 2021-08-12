# frozen_string_literal: true

# ----------------- Controller in Rails ---------------

# Clients Controller with new action
class ClientsController < ApplicationController
  def new
    @client = Client.new
  end
end

# ---------------- Parameters in controller actions ---------------

# Example:
class ClientsController < ApplicationController
  def index
    @clients = if params[:status] == 'activated'
                 Client.activated
               else
                 Client.inactivated
               end
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      redirect_to @client
    else
      render 'new'
    end
  end
end

# ------ JSON parameters
# Example:
# { "company": { "name": 'acme', "address": '123 Carrot Street' } }
# Your controller will receive params[:company] as { "name" => "acme", "address" => "123 Carrot Street" }.

# ------  Routing Parameters
# Example:
get '/clients/:status', to: 'clients#index', foo: 'bar'

# ------ default_url_options
# Example:
class ApplicationController < ActionController::Base
  def default_url_options
    { locale: I18n.locale }
  end
end

# ----- Strong Parameters

# Example:
class PeopleController < ActionController::Base
  def create
    Person.create(params[:person])
  end

  def update
    person = current_account.people.find(params[:id])
    person.update!(person_params)
    redirect_to person
  end

  private

  def person_params
    params.require(:person).permit(:name, :age)
  end
end

# Nested Parameters
params.permit(:name, { emails: [] },
              friends: [:name,
                        { family: [:name], hobbies: [] }])


# ---------------- Rendering XML and JSON data ---------------

# Example:
class UsersController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.xml  { render xml: @users }
      format.json { render json: @users }
    end
  end
end
