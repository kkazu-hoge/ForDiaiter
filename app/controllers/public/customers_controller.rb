class Public::CustomersController < Public::ApplicationController
  def show
  end

  def edit
    @customer = current_customer
  end

  def edit_mail_address
    @customer = current_customer
  end

  def edit_password
  end

  def edit_physical_info
  end

  def update
    @customer = current_customer
    if @customer.update(customer_info_params)
      redirect_to customers_mypage_path, notice: "会員情報が更新されました"
    else
      render 'edit'
    end
  end

  def update_mail_address
    @customer = current_customer
    if @customer.update(customer_email_params)
      redirect_to customers_mypage_path, notice: "メールアドレスが更新されました"
    else
      render 'edit_mail_address'
    end
  end

  def update_password
  end

  def update_physical_info
  end

  def unsubscribe
  end

  def defection
  end


  private
    def customer_info_params
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

    def customer_email_params
    params.require(:customer).permit(
      :email
      )
    end

end
