class Public::PjTemplateEventsController < Public::ApplicationController

  include CalorieCalcuration

  def new
    @pj_event_details = {}
    @trainings = Training.all
  end

  def create
  end

  def destroy
  end

  def pj_event_add_training
    # @pj_event_details = PjEventDetail.new
    # @trainings = Training.all
    # hash_add_training = {"training_id"=>1, "burn_calories"=>0,"activity_minutes"=>0  }
    # session[:pj_event_details]["#{training_id}"] = hash_add_training

    training_obj = Training.find(params[:training_id])
    hash_add_training = {"training_id"=>training_obj.id, "activity_minutes"=>0  }
    if session[:pj_event_details].blank?
      session[:pj_event_details] = {}
    end
    session[:pj_event_details]["#{training_obj.id}"] = hash_add_training

    @training_name = training_obj.name
    minutes = 10
    @calorie_per_ten_min = burn_calories_training(training_obj.mets_value, session[:project]["weight"], minutes).ceil

    respond_to do |format|
      if session[:pj_event_details]["#{training_obj.id}"].blank?
        format.js { @status = "fail" }
      else
        format.js { @status = "success" }
      end
    end
    # binding.pry
  end

  def show_event
  end
end
