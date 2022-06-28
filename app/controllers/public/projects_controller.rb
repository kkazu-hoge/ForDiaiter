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
    success       = 0
    weight_error  = 8
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
      elsif basic_info_validation(params[:project]) == weight_error
        redirect_to request.referer, notice: "目標体重は現在の体重より小さい値を入力ください"
        return
      else
        redirect_to request.referer, notice: "入力されていない項目、または入力値が異常な項目があります"
        return
      end
    end
    #プロジェクト設定画面の表示値をセット
    project = Project.new
    @project = project_info_set(project, session[:project])
    #基礎代謝を参考情報として表示する
    bmr = basal_metabolic_rate(session[:project])
    @life_stress_factor_id_1 = (bmr * LifeStressFactor.find(1).coefficient).to_i #ほぼ運動しない

  end



  def new_wizard3
    #処理ステータスコードの定義
    success               = 0
    pj_date_error         = 8
    intake_calorie_error  = 7
    #リクエスト内容の入力をチェックし問題なければセッションに保存(プロジェクト設定画面からのリクエスト時のみチェック)
    unless params[:project].blank?
      if project_info_validation(params[:project], session[:project]) == success

        #プロジェクト設定画面でセットしたリクエストパラメータをsession情報に保存
        session[:project]["name"] =                  params[:project][:name]
        session[:project]["pj_start_day"] =          params[:project]["pj_start_day"]
        session[:project]["pj_finish_day"] =         params[:project]["pj_finish_day"]
        session[:project]["life_stress_factor_id"] = params[:project][:life_stress_factor_id]
        session[:project]["intake_calorie_perday"] = params[:project][:intake_calorie_perday]
        session[:project]["interval"] =              params[:project][:interval]
      elsif project_info_validation(params[:project], session[:project]) == pj_date_error
        redirect_to request.referer, notice: "プロジェクト開始日は本日以降の日付、プロジェクト終了日はプロジェクト開始日より未来の日付を入力ください"
        return
      elsif project_info_validation(params[:project], session[:project]) == intake_calorie_error
        redirect_to request.referer, notice: "摂取カロリーは３～４桁の値を入力ください"
        return
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
    #処理ステータスコードの定義
    success                       = 0
    training_blank_error          = 8
    input_type_error              = 7
    activity_minutes_blank_error  = 6
    #セッションに保持しているトレーニング内容の入力チェック(プロジェクト設定画面からのリクエスト時のみチェック)
    status_code = training_info_validation(session[:pj_event_details], params)
    if status_code == success
      project_save_transaction(session[:project], session[:pj_event_details])
      #home画面のプルダウンにセットされているプロジェクトを更新し、他のpj関連のsession情報をクリアする
      session[:selected_project] = current_customer.projects.order(created_at: :desc).first
      session[:project].clear
      session[:pj_event_details].clear
      redirect_to complete_projects_path

    elsif status_code == training_blank_error
      # render :new_wizard3
      redirect_to request.referer, notice: "トレーニングを追加してください"
    elsif status_code == input_type_error
      redirect_to request.referer, notice: "トレーニング時間は数値を入力してください"
    elsif status_code == activity_minutes_blank_error
      redirect_to request.referer, notice: "トレーニング時間は1分~999分の間で入力ください"
    else
      redirect_to request.referer, notice: "システムエラーです。管理者に問い合わせてください。"
    end
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
