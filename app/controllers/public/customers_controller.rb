class Public::CustomersController < Public::ApplicationController

  before_action :check_guest_user, except: [:show, :term_of_service, :privacy_policie]

  include Common

  def show
    #使用
  end

  def edit
    @customer = current_customer
    @height_pulldown = height_pulldown_get  #Commonメソッド
    @weight_pulldown = weight_pulldown_get  #Commonメソッド

  end


  def edit_mail_address
    @customer = current_customer
  end


  def update
    @customer = current_customer
    if @customer.update(customer_info_params)
      redirect_to customers_mypage_path, notice: "会員情報が更新されました"
    else
      @height_pulldown = height_pulldown_get  #Commonメソッド
      @weight_pulldown = weight_pulldown_get  #Commonメソッド
      render "edit"
    end
  end

  def update_mail_address
    @customer = current_customer
    if @customer.update(customer_email_params)
      redirect_to customers_mypage_path, notice: "メールアドレスが更新されました"
    else
      render "edit_mail_address"
    end
  end

  def term_of_service
    #使用
  end

  def privacy_policie
    #使用
  end

  def unsubscribe
    #使用
  end

  def defection
    @customer = current_customer
    # is_deletedカラムをtrueに変更して削除フラグを立てる
    if @customer.update(is_deleted: true)
      reset_session
      redirect_to root_path, notice: "退会処理を実行しました"
    else
      redirect_to request.referer, notice: "退会処理が正常に完了しませんでした(管理者にお問い合わせください)"
    end
  end


  private def customer_info_params
      params.delete(:current_password)
      params.require(:customer).permit(
        :last_name,
        :first_name,
        :public_name,
        :sex,
        :birthday,
        :height,
        :weight
        )
    end

  private def customer_email_params
    params.require(:customer).permit(
      :email
      )
    end

  private def check_guest_user
      @customer = Customer.find(current_customer.id)
      if @customer.email == "guest@example.com"
        redirect_to customers_mypage_path , notice: 'ユーザー情報の編集はゲストユーザーではご利用いただけない機能になります'
      end
    end


end
