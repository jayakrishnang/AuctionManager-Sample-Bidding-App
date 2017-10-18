class ApplicationController < ActionController::Base
  
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied"
    redirect_to user_url(:id => current_user.id)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :middle_name, :last_name, :email, :login_id, :password, :password_confirmation, :employee_id, :date_of_birth, :gender, :time_zone, :designation_id, :date_of_joining, :education, :comments, :previous_experience, :work_phone, :avatar])
  end

  protected
  def after_sign_in_path_for(resource)
    if current_user.status=="Active"
      role = current_user.role.try(:name)
      if role == 'admin'
        admin_users_path
      elsif role == 'team_owner'
        team_owner_users_path
      else
        user_path(current_user)
      end
    else
      reset_session
    end
  end
end
