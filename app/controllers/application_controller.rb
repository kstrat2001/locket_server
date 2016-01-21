class ApplicationController < ActionController::Base
  before_action :configure_permitted_params, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  include Authenticable

  def configure_permitted_params
  end

  def after_sign_in_path_for(resource_or_scope)
    site_user_path(current_user)
  end
 
end
