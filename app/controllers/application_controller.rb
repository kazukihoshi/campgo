class ApplicationController < ActionController::Base
  before_action :authenticate, except: [:top]

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def admin_url
    request.fullpath.include?("/admin")
  end


  def authenticate
    if admin_signed_in?
      return true
    elsif user_signed_in?
      if request.fullpath.include?("/admin") &&
        request.fullpath.include?(new_admin_session_path) == false # 二重リダイレクト防止
        redirect_to new_admin_session_path
        return false
      end
      return true
    else
      if request.fullpath.include?(new_user_session_path) == false && # 二重リダイレクト防止
        request.fullpath.include?(new_user_registration_path) == false && # 二重リダイレクト防止
        request.fullpath.include?(users_guest_sign_in_path) == false && # 二重リダイレクト防止
        request.fullpath.include?(new_admin_session_path) == false # 二重リダイレクト防止
        redirect_to new_user_session_path
        return false
      end
    end
  end

end
