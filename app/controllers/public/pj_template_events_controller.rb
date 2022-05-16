class Public::PjTemplateEventsController < Public::ApplicationController
  def new
    @pj_event_details = 
    @trainings = Training.all
  end

  def create
  end

  def destroy
  end

  def pj_event_add_training
    # @pj_event_details = PjEventDetail.new
    # binding.pry
    # @trainings = Training.all

  end

  def show_event
  end
end
