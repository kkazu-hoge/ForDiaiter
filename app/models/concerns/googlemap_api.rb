module GooglemapApi
  extend ActiveSupport::Concern

  include Geokit::Geocoders


  def mapinfo_get(target_name)
    #処理ステータス定義
    success = 0
    gym_not_found = 9
    exception_error = 8
    #初期値セット
    status_code = success
    mapinfo_hash = {}

    results = GoogleGeocoder.geocode(target_name)
    if results.success
      mapinfo_hash[:map_center_lat] = results.lat
      mapinfo_hash[:map_center_lng] = results.lng

      client = GooglePlaces::Client.new(Rails.application.credentials.googlemap[:api_key])
      places = client.spots(results.lat, results.lng, :language => 'ja', :types => 'gym', :radius => 1000)
      status_code = gym_not_found if places.blank?

      if status_code == success
        # 3次元hashの初期化
        marker_places = Hash.new { |h,k| h[k] = Hash.new(&h.default_proc) }
        i = 0
        places.each do |place|
          marker_places[i]["name"]      = place["name"]
          marker_places[i]["lat"]       = place["lat"]
          marker_places[i]["lng"]       = place["lng"]
          place["rating"].blank? ? marker_places[i]["rating"] = "?" : marker_places[i]["rating"] = place["rating"]
          marker_places[i]["vicinity"]  = place["json_result_object"]["vicinity"]
          place.photos[0].blank? ? marker_places[i]["photo_image"] = "" : marker_places[i]["photo_image"] = place.photos[0].fetch_url(200)

          i = i+1
        end
      end
    else
      status_code = exception_error
    end

    return status_code, mapinfo_hash, marker_places
  end


end