module Newsapi
  extend ActiveSupport::Concern

  require 'news-api'

  def find_news
    newsapi = News.new(Rails.application.credentials.newsapi[:api_key])

    news_headlines = newsapi.get_top_headlines(q: 'ダイエット',
                                          category: 'health',
                                          language: 'jp',
                                          country: 'jp',
                                          pageSize: 1)
    # top_headlines = newsapi.get_top_headlines(category: 'health',
    #                                       language: 'jp',
    #                                       country: 'jp',
    #                                       pageSize: 1)
    return news_headlines
  end

end