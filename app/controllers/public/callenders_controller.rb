class Public::CallendersController < Public::ApplicationController

   include CalorieCalcuration

  def edit
    @pj_event =         PjEvent.find(params[:pj_event_id])
    @pj_event_details = @pj_event.pj_event_details
    #プロジェクト新規作成時の計画情報取得
    @plan_pj_event_details =  PlanPjEvent.find_by(project_id: @pj_event.project_id).plan_pj_event_details
    @plan_sum_burn_cals =     0
    @plan_pj_event_details.each do |pped|
      @plan_sum_burn_cals += pped.burn_calories
    end
  end

  def new
  end

  def show
    @projects = Project.get_projects_sort_desc_createday(current_customer)
    @projects.blank? ? @projects_array = [] : @projects_array = @projects.get_projects_pulldown_list
    @pj_pulldown_initial_set_value = @projects_array.first
    project = @projects.first
    if project.blank?
      @pj_events = ""
    else
      @pj_events = PjEvent.where(project_id: project.id)
    end
  end

  def update
    #プロジェクトの体重情報が必要なためproject取得
    pj_event =  PjEvent.find(params[:pj_event_id])
    project =   Project.find(pj_event.project_id)
    #配列要素指定のため変数として定義
    pj_event_details_id = 0
    activity_minutes =    1
    #詳細の数だけトレーニング時間、消費カロリーを保存する
    params[:pj_event_detail].each do |ped|
      # binding.pry
      pj_event_detail =                   PjEventDetail.find(ped[pj_event_details_id])
      pj_event_detail.activity_minutes =  ped[activity_minutes]
      mets_value =                        Training.find(pj_event_detail.training_id).mets_value
      pj_event_detail.burn_calories =     burn_calories_training(mets_value.to_f, project.weight.to_i, ped[activity_minutes].to_i)
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

  private
  # def new_params
  #   params.require(:pj_event_detail).permit(
  #     :sex,
  #     :age,
  #     :height,
  #     :weight,
  #     :target_weight
  #     )
  # end

end
