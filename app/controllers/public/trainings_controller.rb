class Public::TrainingsController < Public::ApplicationController
  def index
    
    @trainings = Training.all
    
  end

  def show
  end
end
