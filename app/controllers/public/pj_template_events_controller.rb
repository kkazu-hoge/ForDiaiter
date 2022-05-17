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

    #リクエストパラメータのトレーニングidからトレーニングデータを取得
    training_obj = Training.find(params[:training_id])
    minutes = 10
    calorie_per_ten_min = burn_calories_training(training_obj.mets_value, session[:project]["weight"], minutes).ceil
    #ハッシュで１トレーニングのデータを作成する
    hash_add_training = {"training_id"=>training_obj.id, "activity_minutes"=>0, "training_name"=>training_obj.name, "calorie_per_ten_min"=>calorie_per_ten_min }
    if session[:pj_event_details].blank?
      session[:pj_event_details] = {}
    end
    #セッションに1トレーニング分のハッシュデータを追加する
    session[:pj_event_details]["#{training_obj.id}"] = hash_add_training

    @pj_event_details = session[:pj_event_details]

    respond_to do |format|
      if session[:pj_event_details]["#{training_obj.id}"].blank?
        format.js { @status = "fail" }
      else
        format.js { @status = "success" }
      end
    end
  end

  def show_event
  end
end
