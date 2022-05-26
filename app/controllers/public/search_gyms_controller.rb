class Public::SearchGymsController < Public::ApplicationController
  def index
  end

  def search
    @center_name = params[:place_name]
    results = Geocoder.search(@center_name) #本番ではエラーが発生する(原因は本番だとhttp通信でセキュアでないためAPI側で許可されない)
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

    # 3次元hashの初期化
    @marker_places = Hash.new { |h,k| h[k] = Hash.new(&h.default_proc) }
    i = 0
    @places.each do |place|
      @marker_places[i]["name"] = place["name"]
      @marker_places[i]["lat"] = place["lat"]
      @marker_places[i]["lng"] = place["lng"]
      @marker_places[i]["rating"] = place["rating"]
      @marker_places[i]["vicinity"] = place["json_result_object"]["vicinity"]
      # binding.pry
      unless place.photos[0].blank?
        @marker_places[i]["photo_image"] = place.photos[0].fetch_url(200)
      else
        @marker_places[i]["photo_image"] = ""
      end
      i = i+1
    end

    @array_marker_places = @marker_places.to_a
    gon.array_marker_places = @array_marker_places
    # binding.pry
  end

end
