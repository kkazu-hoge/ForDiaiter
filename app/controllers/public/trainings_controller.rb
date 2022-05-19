class Public::TrainingsController < Public::ApplicationController

  include Youtube


  def index

    @trainings = Training.all

  end

  def show
    training = Training.find(params[:id])
    @youtube_data = find_videos("トレーニング "+"#{training.name}")
  end



  # require 'google/apis/youtube_v3'
  # GOOGLE_API_KEY = Rails.application.credentials.youtube[:api_key]

  # def find_videos(keyword, after: 1.months.ago, before: Time.now) #検索キーワードと検索範囲を変えれるように引数に値を取っています
  #   service = Google::Apis::YoutubeV3::YouTubeService.new
  #   service.key = GOOGLE_API_KEY

  #   next_page_token = nil
  #   opt = {
  #     q: keyword,
  #     type: 'video',
  #     max_results: 2,
  #     order: :date,
  #     page_token: next_page_token,
  #     published_after: after.iso8601,
  #     published_before: before.iso8601
  #   }
  #   results = service.list_searches(:snippet, opt)
  #   return results
  # end



end
