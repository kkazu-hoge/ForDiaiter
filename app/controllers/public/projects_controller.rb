class Public::ProjectsController < Public::ApplicationController

  include CalorieCalcuration
  include Common

  before_action :initial_value_set, only: [:new]


  def index
  end

  def show
  end

  def new
    @project = Project.new
    #sessionに情報保持していなければ会員情報の値をセット
    if session[:project].blank?
      @project["sex"] =           current_customer.sex
      @project["age"] =           Customer.birthday_transfer_age(current_customer.birthday)
      @project["height"] =        current_customer.height
      @project["weight"] =        current_customer.weight
      @project["target_weight"] = ""
    else
      @project["sex"] =           session[:project]["sex"]
      @project["age"] =           session[:project]["age"]
      @project["height"] =        session[:project]["height"]
      @project["weight"] =        session[:project]["weight"]
      @project["target_weight"] = session[:project]["target_weight"]
    end
  end


  def new_wizard2
    #セッションにprojectモデルが紐づいていない場合はオブジェクトを生成する
    if session[:project].blank?
      session[:project] = Project.new
    end

    #リクエスト内容の入力チェック・バリデーションの実装が必要

    #基礎情報入力画面でセットしたリクエストパラメータをsession情報に保存
    unless params[:project].blank?
      session[:project]["sex"] =           params[:project][:sex]
      session[:project]["age"] =           params[:project][:age]
      session[:project]["height"] =        params[:project][:height]
      session[:project]["weight"] =        params[:project][:weight]
      session[:project]["target_weight"] = params[:project][:target_weight]
    end

    #プロジェクト設定の値を設定
    @project = Project.new
    if session[:project]["name"].blank?
      @project["name"] =                  ""
      @project["pj_start_day"] =          Date.current
      @project["pj_finish_day"] =         Date.current
      @project["life_stress_factor_id"] = 1
      @project["intake_calorie_perday"] = ""
      @project["interval"] =              ""
    else
      # binding/pry
      @project["name"] =                  session[:project]["name"]
      @project["pj_start_day"] =          session[:project]["pj_start_day"]
      @project["pj_finish_day"] =         session[:project]["pj_finish_day"]
      @project["life_stress_factor_id"] = session[:project]["life_stress_factor_id"]
      @project["intake_calorie_perday"] = session[:project]["intake_calorie_perday"]
      @project["interval"] =              session[:project]["interval"]
    end
  end


  def new_wizard3
    #リクエスト内容の入力チェック・バリデーションの実装が必要

    #プロジェクト設定画面でセットしたリクエストパラメータをsession情報に保存
    unless params[:project].blank?
      pj_start_day = Date.new params[:project]["pj_start_day(1i)"].to_i,params[:project]["pj_start_day(2i)"].to_i,params[:project]["pj_start_day(3i)"].to_i
      pj_finish_day = Date.new params[:project]["pj_finish_day(1i)"].to_i,params[:project]["pj_finish_day(2i)"].to_i,params[:project]["pj_finish_day(3i)"].to_i

      session[:project]["name"] =                  params[:project][:name]
      session[:project]["pj_start_day"] =          pj_start_day
      session[:project]["pj_finish_day"] =         pj_finish_day
      session[:project]["life_stress_factor_id"] = params[:project][:life_stress_factor_id]
      session[:project]["intake_calorie_perday"] = params[:project][:intake_calorie_perday]
      session[:project]["interval"] =              params[:project][:interval]
    end

    #表示用データ
    tmp_project = session[:project]

    @weight = tmp_project["weight"]
    @target_weight = tmp_project["target_weight"]

    bmr =                           basal_metabolic_rate(tmp_project)
    naturally_burn_calorie_perday = bmr.to_f * LifeStressFactor.find(tmp_project["life_stress_factor_id"].to_i).coefficient
    intake_calorie_perday =         tmp_project["intake_calorie_perday"].to_f
    diff_calorie_perday =           diff_calorie_perday(intake_calorie_perday,naturally_burn_calorie_perday)
    pj_scope_day_counts =           day_counts(tmp_project["pj_start_day"].to_date, tmp_project["pj_finish_day"].to_date)
    sum_diff_calorie =              diff_calorie_perday.to_i * pj_scope_day_counts.to_i
    @target_burn_kcal =             target_burn_kcal(tmp_project, sum_diff_calorie)
    @event_counts =                 event_counts_calc(tmp_project["pj_finish_day"].to_date, tmp_project["pj_start_day"].to_date,tmp_project["interval"].to_i)
    @target_burn_kcal_per_event =  (@target_burn_kcal.to_f/@event_counts).ceil


  end

  def edit
  end

  def cretae

    # #session情報をクリアする
    # session[:project] = nil
  
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
