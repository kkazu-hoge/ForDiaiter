class Public::ProjectsController < Public::ApplicationController

  include Common

  before_action :initial_value_set, only: [:new]


  def index
  end

  def show
  end

  def new
    #sessionに情報保持していなければ会員情報の値をセット
    if session[:project].blank?
      @customer = current_customer
      @customer_age = @customer.birthday_transfer_age(@customer::birthday)
      @customer_target_weight = ""
    else
      @customer = session[:project]
      @customer_age = @customer["age"]
      @customer_target_weight = @customer["target_weight"]
    end
    @project = Project.new
  end

  def new_wizard2
    #基礎情報入力画面でセットしたリクエストパラメータをsession情報に保存
    session[:project] = new_params

    # #session情報をクリアする
    # session[:project] = nil

  end

  def new_wizard3
  end

  def edit
  end

  def cretae
  end

  def update
  end


  private

  def initial_value_set
    @height_pulldown = height_pulldown_get  #Commonメソッド
    @weight_pulldown = weight_pulldown_get  #Commonメソッド
    @age_pulldown    = age_pulldown_get  #Commonメソッド
  end

  def new_params
    params.require(:project).permit(
      :sex,
      :age,
      :height,
      :weight,
      :target_weight
      )
  end

end
