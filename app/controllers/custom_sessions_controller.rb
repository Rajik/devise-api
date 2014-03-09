class CustomSessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :authenticate_user!, :except => [:create, :destroy]
  skip_before_filter :require_no_authentication
  respond_to :json

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    self.resource = warden.authenticate!(:scope => resource_name, :recall => "custom_sessions#invalid_login_attempt")

    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    render :json => {:success => true, :user => resource}

  end


  def after_sign_in_path_for resource
    render :json => {:success => true, :user => resource}
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

  #def resource
  #  User.find ||= User.new
  #end
end
