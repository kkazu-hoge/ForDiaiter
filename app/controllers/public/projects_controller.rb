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


  def create
    #１ projectを保存する
    project = Project.new

    project[:customer_id] =           current_customer.id
    project[:sex] =                   session[:project]["sex"]
    project[:age]	=		                session[:project]["age"].to_i
    project[:height] =	              session[:project]["height"].to_i
    project[:weight] =                session[:project]["weight"].to_i
    project[:target_weight] =         session[:project]["target_weight"].to_i
    project[:name] =                  session[:project]["name"]
    project[:pj_start_day] =          session[:project]["pj_start_day"].to_date
    project[:pj_finish_day] =         session[:project]["pj_finish_day"].to_date
    project[:life_stress_factor_id] = session[:project]["life_stress_factor_id"].to_i
    project[:intake_calorie_perday] = session[:project]["intake_calorie_perday"].to_i
    project[:interval] =              session[:project]["interval"].to_i

    project.save

    #２ plan_pj_eventsを保存する
    plan_pj_event = PlanPjEvent.new(project_id: project.id)
    plan_pj_event.save

    #３ plan_pj_event_detailsを保存する
    # binding.pry
    session[:pj_event_details].each do |ped|
      plan_pj_event_details = PlanPjEventDetail.new
      plan_pj_event_details[:plan_pj_event_id] = plan_pj_event.id
      plan_pj_event_details[:training_id] = ped[1]["training_id"]
      plan_pj_event_details[:activity_minutes] = params[ped[1]["training_id"].to_s]
      training = Training.find(plan_pj_event_details[:training_id].to_i)
      plan_pj_event_details[:burn_calories] = burn_calories_training(training.mets_value, project[:weight], plan_pj_event_details[:activity_minutes] )
      # binding.pry
      plan_pj_event_details.save
    end

    #４ pj_eventsを保存する
    #５ pj_event_detailsを保存する
      event_counts = event_counts_calc(project[:pj_finish_day], project[:pj_start_day], project[:interval])
      num = 1
      action_day = project[:pj_start_day]
      while num <= event_counts do
      	pj_event = PjEvent.new(project_id: project.id)
      	pj_event[:action_day] = action_day
      	pj_event[:start_time] = pj_event[:action_day].to_time.to_datetime
      	pj_event.save

      	session[:pj_event_details].each do |ped|
      	  pj_event_details = PjEventDetail.new
          pj_event_details[:pj_event_id] = pj_event.id
        	pj_event_details[:training_id] = ped[1]["training_id"]
      	  pj_event_details.save
        end

        action_day = action_day.days_since(project[:interval])
      	num +=1
      end

    #６ session情報をクリアする
    session[:project].clear
    session[:pj_event_details].clear

    # session[:project] = nil
    # session[:pj_event_details] = nil

    #7  完了画面に遷移する
    redirect_to complete_projects_path
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
