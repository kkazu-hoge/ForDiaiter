class Public::CallendersController < Public::ApplicationController
  def edit
    pj_event = PjEvent.find(params[:pj_event_id])
    @pj_event_details = pj_event.pj_event_details
    #プロジェクト新規作成時の計画情報取得
    @plan_pj_event_details = PlanPjEvent.find_by(project_id: pj_event.project_id).plan_pj_event_details
    @plan_sum_burn_cals = 0
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

    @pj_events = PjEvent.where(project_id: project.id)
  end
end
