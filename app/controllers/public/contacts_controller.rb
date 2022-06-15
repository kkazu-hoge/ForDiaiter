class Public::ContactsController < Public::ApplicationController

  protect_from_forgery

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact, Customer.find(@contact.customer_id)).deliver
      redirect_to root_path, notice: "お問い合わせ内容を送信しました"
    else
      render :new
    end
  end





  private def contact_params
    params.require(:contact).permit(:name, :content, :customer_id)
  end


end
