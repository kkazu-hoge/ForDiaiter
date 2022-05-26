class Public::SearchGymsController < Public::ApplicationController
  def index
  end

  def search
    @center_name = params[:place_name]
    results = Geocoder.search(@center_name) #本番ではエラーが発生する
    if results.blank?
      redirect_to request.referer, notice: "検索対象の場所情報を取得できませんでした。条件を変更して再度検索ください。"
      return
    else
      @map_center_lat = results.first.coordinates[0]
      @map_center_lng = results.first.coordinates[1]
      client = GooglePlaces::Client.new(Rails.application.credentials.googlemap[:api_key])
      @places = client.spots(@map_center_lat, @map_center_lng, :language => 'ja', :types => 'gym', :radius => 1000)
      if @places.blank?
        redirect_to request.referer, notice: "半径1km以内にジムが見つかりませんでした。条件を変更して再度検索ください。"
      end

    end
    # places = {}
    # i = 0
    # @places.each do |place|
    #   places[i]["name"] = place["name"]
    #   places[i]["lat"] = place["lat"]
    #   places[i]["lng"] = place["lng"]
    #   places[i]["rating"] = place["rating"]
    #   places[i]["photo"] = place.photos[0].fetch_url(400)
    #   places[i]["vicinity"] = place["json_result_object"]["vicinity"]
    #   places[i]["compound_code"] = place["json_result_object"]["plus_code"]["compound_code"]
    #   i++
    # end

  end

end
