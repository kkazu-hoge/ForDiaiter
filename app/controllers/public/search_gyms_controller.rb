class Public::SearchGymsController < Public::ApplicationController

  include GooglemapApi


  def index
    #利用している
  end

  def search
    @center_name = params[:place_name]
    #検索キーワードを引数にマップ表示に必要な情報を取得する
    map_info      = mapinfo_get(@center_name)
    status_code   = map_info[0]
    mapinfo_hash  = map_info[1]
    marker_places = map_info[2]

    if status_code == 0
      @marker_places  = marker_places
      @map_center_lat = mapinfo_hash[:map_center_lat]
      @map_center_lng =  mapinfo_hash[:map_center_lng]
      gon.array_marker_places = @marker_places.to_a

    elsif status_code == 9
      redirect_to request.referer, alert: "半径1km以内にジムが見つかりませんでした。条件を変更して再度検索ください。"
    else
      redirect_to request.referer, alert: "検索地点の場所情報を取得できませんでした。条件を変更して再度検索ください。"
    end
  end


end
