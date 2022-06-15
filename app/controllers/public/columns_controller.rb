class Public::ColumnsController < Public::ApplicationController

  include Newsapi

  def index
    @news_headlines = find_news
  end

end
