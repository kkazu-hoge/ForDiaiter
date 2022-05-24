class Public::ProjectsController < Public::ApplicationController

  include Common
  include CalorieCalcuration
  include ServiceProject

  before_action :initial_value_set, only: [:new]


  def index
  end


  def show
  end


  def new
    project = Project.new
    #sessionに情報保持していなければ会員情報の値をprojectにセット(ServiceProject module)
    @project = basic_info_set(project, session[:project], current_customer)
  end



  def new_wizard2
    #処理ステータスコードの定義
    success = 0
    #リクエスト内容の入力チェック(基礎情報入力画面からのリクエスト時のみチェック)
    unless params[:project].blank?
      if basic_info_validation(params[:project]) == success
        #セッションにprojectが紐づいていない場合はオブジェクトを生成する
        if session[:project].blank?
          session[:project] = Project.new
        end
        #基礎情報入力画面でセットしたリクエストパラメータをsession情報に保存
        session[:project]["sex"] =           params[:project][:sex]
        session[:project]["age"] =           params[:project][:age]
        session[:project]["height"] =        params[:project][:height]
        session[:project]["weight"] =        params[:project][:weight]
        session[:project]["target_weight"] = params[:project][:target_weight]
      else
        redirect_to request.referer, notice: "入力されていない項目、または入力値が異常な項目があります"
        return
        # @project = basic_info_set(Project.new, session[:project], current_customer)
        # render "/projects/new"
      end
    end

    #プロジェクト設定画面の表示値をセット
    project = Project.new
    @project = project_info_set(project, session[:project])
  end



  def new_wizard3
    #処理ステータスコードの定義
    success = 0
    #リクエスト内容の入力チェック(プロジェクト設定画面からのリクエスト時のみチェック)
    unless params[:project].blank?
      if project_info_validation(params[:project], session[:project]) == success

        #プロジェクト設定画面でセットしたリクエストパラメータをsession情報に保存
        session[:project]["name"] =                  params[:project][:name]
        session[:project]["pj_start_day"] =          params[:project]["pj_start_day"]
        session[:project]["pj_finish_day"] =         params[:project]["pj_finish_day"]
        session[:project]["life_stress_factor_id"] = params[:project][:life_stress_factor_id]
        session[:project]["intake_calorie_perday"] = params[:project][:intake_calorie_perday]
        session[:project]["interval"] =              params[:project][:interval]
      else
        redirect_to request.referer, notice: "入力されていない項目、または入力値が異常な項目があります"
        return
      end
    end

    #トレーニング設定画面の表示値をセット
    @weight = session[:project]["weight"]
    @target_weight = session[:project]["target_weight"]

    tmp_project = training_info_set(session[:project])
    @target_burn_kcal =            tmp_project["target_burn_kcal"]
    @event_counts =                tmp_project["event_counts"]
    @target_burn_kcal_per_event =  tmp_project["target_burn_kcal_per_event"]

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
    session[:pj_event_details].each do |ped|
      plan_pj_event_details =                     PlanPjEventDetail.new
      plan_pj_event_details[:plan_pj_event_id] =  plan_pj_event.id
      plan_pj_event_details[:training_id] =       ped[1]["training_id"]
      plan_pj_event_details[:activity_minutes] =  params[ped[1]["training_id"].to_s]
      training =                                  Training.find(plan_pj_event_details[:training_id].to_i)
      plan_pj_event_details[:burn_calories] =     burn_calories_training(training.mets_value, project[:weight], plan_pj_event_details[:activity_minutes] )

      plan_pj_event_details.save
    end

    #４ pj_eventsを保存する
    #５ pj_event_detailsを保存する
      event_counts = event_counts_calc(project[:pj_finish_day], project[:pj_start_day], project[:interval])
      num = 1
      action_day = project[:pj_start_day]
      while num <= event_counts do
      	pj_event =              PjEvent.new(project_id: project.id)
      	pj_event[:action_day] = action_day
      	pj_event[:start_time] = pj_event[:action_day].to_time.to_datetime
      	pj_event.save

      	session[:pj_event_details].each do |ped|
      	  pj_event_details =               PjEventDetail.new
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

    #7  完了画面に遷移する
    redirect_to complete_projects_path
  end

  def update
  end


  private def initial_value_set
    @height_pulldown = height_pulldown_get  #Commonメソッド
    @weight_pulldown = weight_pulldown_get  #Commonメソッド
    @age_pulldown    = age_pulldown_get  #Commonメソッド
  end


  private def new_params
    params.require(:project).permit(
      :sex,
      :age,
      :height,
      :weight,
      :target_weight
      )
  end


end
