class Public::PjEventsController < Public::ApplicationController

  include CalorieCalcuration

  def show
  end

  def new
    @project_id = params[:project_id]
    # if session[:pj_event_details_new]["action_day"].blank?
      @action_day = Date.current
      # session[:pj_event_details_new]["action_day"] = @action_day
    # else
    #   @action_day = session[:pj_event_details_new]["action_day"]
    # end
  end

  def edit
  end

  def update
  end

  def create

    project = Project.find(params[:project_id])
    action_day = params[:action_day].to_date

    # ActiveRecord::Base.transaction do
      # pj_eventを保存する
      pj_event = PjEvent.new(project_id: project.id)
      pj_event[:action_day] = action_day
      pj_event[:start_time] = pj_event[:action_day].to_time.to_datetime
      pj_event.save!
      # pj_event_detailsを保存する
      session[:pj_event_details_new]
      session[:pj_event_details_new].each do |ped|

    	  pj_event_details = PjEventDetail.new
        pj_event_details[:pj_event_id] = pj_event.id
      	pj_event_details[:training_id] = ped[1]["training_id"]
      	training = Training.find(pj_event_details[:training_id].to_i)
    	  pj_event_details[:activity_minutes] = params[training.id.to_s]
    	  pj_event_details[:burn_calories] = burn_calories_training(training.mets_value, project["weight"], pj_event_details[:activity_minutes].to_i )
    	  pj_event_details.save!
      end
    # end

    # session情報をクリアする
    session[:pj_event_details_new].clear

    redirect_to callender_path(id: current_customer.id)

  end

  def destroy
    # binding.pry
    pj_event = PjEvent.find(params[:id])
    if pj_event.destroy
      redirect_to callender_path(id: current_customer.id), notice: "イベントを1件(#{pj_event.action_day.strftime("%m/%d")})削除しました"
    else
      redirect_to callender_path(id: current_customer.id), notice: "イベントを削除できませんでした(#{pj_event.action_day.strftime("%m/%d")})"
    end

  end

  def new_training
    @pj_event_details = {}
    @trainings = Training.all
    @project_id = params["project_id"]
  end

  def pj_event_add_training_new
    #リクエストパラメータのトレーニングidからトレーニングデータを取得
    training_obj = Training.find(params[:training_id])
    @project = Project.find(params[:project_id])
    minutes = 10
    calorie_per_ten_min = burn_calories_training(training_obj.mets_value,  @project["weight"], minutes).ceil
    #ハッシュで１トレーニングのデータを作成する
    hash_add_training = {"training_id"=>training_obj.id, "activity_minutes"=>0, "training_name"=>training_obj.name, "calorie_per_ten_min"=>calorie_per_ten_min }
    if session[:pj_event_details_new].blank?
      session[:pj_event_details_new] = {}
    end
    #セッションに1トレーニング分のハッシュデータを追加する
    session[:pj_event_details_new]["#{training_obj.id}"] = hash_add_training

    @pj_event_details = session[:pj_event_details_new]
    @action_day = Date.current

    respond_to do |format|
      if session[:pj_event_details_new]["#{training_obj.id}"].blank?
        format.js { @status = "fail" }
      else
        format.js { @status = "success" }
      end
    end
  end

  def pj_event_delete_training_new
    #セッションから該当の情報を削除する
    session[:pj_event_details_new].delete(params[:training_id])
    @training_id = params[:training_id]

    #jsに渡す処理結果を定義
    respond_to do |format|
      if session[:pj_event_details_new][@training_id].blank?
        format.js { @status = "success" }
      else
        format.js { @status = "fail" }
      end
    end
  end

end
