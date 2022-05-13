# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController

  layout 'public/application'

  #退会しているかcreate時(ログイン)のみ確認
  before_action :confirm_defection, only: [:create]

  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to home_path, notice: "ゲストユーザーとしてログインしました"
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end


  #ログイン時に退会済の場合、新規登録画面にリダイレクト
  def confirm_defection
    customer = Customer.find_by_email(params[:customer][:email])
    return if !customer
    if customer.valid_password?(params[:customer][:password]) && customer.is_deleted == "unsubscribed"
      redirect_to new_customer_registration_path, notice: "退会済のためログインできません。新しくアカウントをご登録ください。"
    end
  end


end
