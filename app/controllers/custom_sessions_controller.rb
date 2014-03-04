class CustomSessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :authenticate_user!, :except => [:create, :destroy]
  skip_before_filter :require_no_authentication
  respond_to :json

  def create
    resource = User.find_for_database_authentication(:email => params[:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:password])
      sign_in(:user, resource)
      render :json => {:success => true, :user => resource }
      return
    end
    invalid_login_attempt

  end

  def invalid_login_attempt
    render :json => {:success => false, :message => "Error with your login or password"}, :status => 401
  end


  def destroy
    resource = User.find_for_database_authentication(:email => params[:email])
    resource.save
    render :json => {:success => true}
  end

  def failure
    render :json => {:error => "Login failed"}, :status => 401
  end

  def show_current_user
    render :json => {:user => current_user}, :status => 200
  end

  def resource
    @resource ||= User.new
  end
end
