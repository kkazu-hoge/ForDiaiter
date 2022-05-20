class Public::TrainingsController < Public::ApplicationController

  include Youtube


  def index

    @trainings = Training.all

  end

  def show
    training = Training.find(params[:id])
    # @youtube_data = find_videos("#{training.name}")
    ## @youtube_data = find_videos("#{training.name}"+" トレーニング")
  end
  
  # def set_q
  #   @q = Training.ransack(params[:q])
  # end
  
  # def search
  #   @results = @q.result
  # end
  

end
