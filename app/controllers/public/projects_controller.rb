class Public::ProjectsController < Public::ApplicationController

  include Common

  before_action :initial_valu_set, only: [:new]


  def index
  end

  def show
  end

  def new
    @customer = current_customer

  end

  def new_wizard2
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

  def initial_valu_set
    @height_pulldown = height_pulldown_get  #Commonメソッド
    @weight_pulldown = weight_pulldown_get  #Commonメソッド
  end

end
