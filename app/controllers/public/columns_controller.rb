class Public::ColumnsController < Public::ApplicationController

  include Newsapi

  def index
    key_word_1 = "ダイエット"
    key_word_2 = "健康"
    @diet_news_headlines = find_news(key_word_1)
    @health_news_headlines = find_news(key_word_2)
  end

end
