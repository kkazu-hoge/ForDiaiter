module Newsapi
  extend ActiveSupport::Concern

  require 'news-api'

  def find_news
    newsapi = News.new(Rails.application.credentials.newsapi[:api_key])
    #URLエンコードの値は"ダイエット"
    news_headlines = newsapi.get_everything(q: '%E3%83%80%E3%82%A4%E3%82%A8%E3%83%83%E3%83%88',
                                          searchIn: 'description',
                                          from: (Date.current << 1).strftime("%Y-%m-%d"),
                                          to: Date.current.strftime("%Y-%m-%d"),
                                          excludeDomains: 'alfalfalfa.com, himasoku.com, livedoor.biz, 2chblog.jp, livedoor.jp',
                                          language: 'jp',
                                          sortBy: 'relevancy',
                                          pageSize: 15)
    return news_headlines
  end

end