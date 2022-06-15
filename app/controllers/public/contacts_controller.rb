class Public::ContactsController < Public::ApplicationController

  protect_from_forgery

  def new
    @contact = Contact.new
    @customer_id = current_customer.id
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


end
