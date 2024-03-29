class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  include ErrorHandlers

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when Customer
      home_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :customer
      new_customer_session_path
    end
  end

  def after_sign_up_path_for(resource)
    case resource
    when Customer
      home_path
    end
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [
      :last_name,
      :first_name,
      :public_name,
      :sex,
      :birthday,
      :height,
      :weight
      ])
  end

end
