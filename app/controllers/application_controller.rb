class ApplicationController < ActionController::Base

  # before_action :configure_permitted_parameters, if: :devise_controller?


  # def after_sign_in_path_for(resource)
  #   case resource
  #   when Admin
  #     admin_root_path
  #   when Customer
  #     root_path
  #   end
  # end

  # def after_sign_out_path_for(resource)
  #   case resource
  #   when :admin
  #     new_admin_session_path
  #   when :customer
  #     new_customer_session_path
  #   end
  # end

  # def after_sign_up_path_for(resource)
  #   case resource
  #   when Customer
  #     customers_mypage_path
  #   end
  # end

  # protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up,
  #     keys: [:name,
  #     :last_name,
  #     :first_name,
  #     :last_name_kana,
  #     :first_name_kana,
  #     :post_code,
  #     :address,
  #     :phone_number
  #     ])
  # end


end
