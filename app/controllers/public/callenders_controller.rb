class Public::CallendersController < Public::ApplicationController
  def edit
    @trainings = Training.all
    @pj_event = PjEvent.find(params[:pj_event_id])
    @pj_event_details = 
    
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
