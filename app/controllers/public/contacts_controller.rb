class Public::ContactsController < Public::ApplicationController

  protect_from_forgery
  before_action :check_guest_user, only: [:new]

  def new
    @contact = Contact.new
    @customer_id = current_customer.id
    @customer_name = "#{current_customer.last_name}" << " " << "#{current_customer.first_name}"
  end


  def create
    @customer_id = params[:contact][:customer_id]
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact, Customer.find(@contact.customer_id)).deliver
      redirect_to home_path, notice: "お問い合わせ内容を送信しました"
    else
      render :new
    end
  end


  private def contact_params
    params.require(:contact).permit(:name, :content, :customer_id)
  end

  private def check_guest_user
    @customer = Customer.find(current_customer.id)
    if @customer.email == "guest@example.com"
      redirect_to home_path, notice: "お問い合わせはゲストユーザーではご利用いただけない機能になります"
    end
  end

end
