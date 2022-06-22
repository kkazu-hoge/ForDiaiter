class Public::CallendersController < Public::ApplicationController

   include CalorieCalcuration

  def edit
    @pj_event         = PjEvent.find(params[:pj_event_id])
    @pj_event_details = @pj_event.pj_event_details
    #プロジェクト新規作成時の計画情報取得
    @plan_pj_event_details =  PlanPjEvent.find_by(project_id: @pj_event.project_id).plan_pj_event_details
    @plan_sum_burn_cals    = 0
    @plan_pj_event_details.each do |pped|
      @plan_sum_burn_cals += pped.burn_calories
    end
  end

  def show
    #プルダウン用のデータ取得
    @projects = Project.get_projects_sort_desc_createday(current_customer)
    @projects.blank? ? @projects_array = [] : @projects_array = @projects.get_projects_pulldown_list
    #セッションに選択中のプロジェクトがあればそちらを使用する
    if session[:selected_project].blank?
      @pj_pulldown_initial_set_value = @projects_array.first
      @project = @projects.first
    else
      project_id = 1
      @pj_pulldown_initial_set_value = @projects_array.find{|val| val[project_id] == session[:selected_project]["id"]}
      @project = session[:selected_project]
    end

    if @project.blank?
      @pj_events = ""
    else
      @pj_events = PjEvent.where(project_id: @project["id"])
    end
  end


  def update
    #処理ステータスを定義
    success = 0
    input_error = 9
    status = input_error
    #プロジェクトの体重情報が必要なためproject取得
    pj_event =  PjEvent.find(params[:pj_event_id])
    project =   Project.find(pj_event.project_id)
    #配列要素指定のため変数として定義
    pj_event_details_id = 0
    activity_minutes =    1
    #詳細の数だけトレーニング時間、消費カロリーを保存する
    params[:pj_event_detail].each do |ped|
      pj_event_detail = PjEventDetail.find(ped[pj_event_details_id])
      if ped[activity_minutes].blank?
        pj_event_detail.activity_minutes = 0
      else
        pj_event_detail.activity_minutes = ped[activity_minutes]
      end
      mets_value                    = Training.find(pj_event_detail.training_id).mets_value
      pj_event_detail.burn_calories = burn_calories_training(mets_value.to_f, project.weight.to_i, pj_event_detail.activity_minutes.to_i)
      pj_event_detail.save
    end

    # jsに渡す処理結果を定義
    respond_to do |format|
      if 
        format.js { @status = "success" }
      else
        format.js { @status = "fail" }
      end
    end
  end


end
