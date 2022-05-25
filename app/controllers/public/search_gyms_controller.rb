class Public::SearchGymsController < Public::ApplicationController
  def index
    results = Geocoder.search("東京")
    @lat = results.first.coordinates[0]
    @lng = results.first.coordinates[1]
    # binding.pry
  end

  def search
    place_name = params[:place_name]
    results = Geocoder.search("東京")
    @lat = results.first.coordinates[0]
    @lng = results.first.coordinates[1]

  end
end
