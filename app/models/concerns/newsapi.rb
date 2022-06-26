module Newsapi
  extend ActiveSupport::Concern

  require 'news-api'

  def find_news(key_word)
    newsapi = News.new(Rails.application.credentials.newsapi[:api_key])
    search_key = URI.escape(key_word)
    news_headlines = newsapi.get_everything(q: search_key,
                                          searchIn: 'description',
                                          from: (Date.current << 1).strftime("%Y-%m-%d"),
                                          to: Date.current.strftime("%Y-%m-%d"),
                                          excludeDomains: 'alfalfalfa.com,
                                            himasoku.com,
                                            livedoor.biz,
                                            2chblog.jp, livedoor.jp,
                                            scienceplus2ch.com,
                                            matometanews.com,
                                            *2ch*, *4ch*, *5ch*,
                                            *matome*, po-kaki-to.com,
                                            goo.ne.jp',
                                          language: 'jp',
                                          sortBy: 'relevancy',
                                          pageSize: 20)
    return news_headlines
  end

end