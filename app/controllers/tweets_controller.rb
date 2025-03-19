class TweetsController < ApplicationController
  def index
    @tweets = fetch_tweets
  end

  def show
    if params["tweet"]
      @tweet = params["tweet"]
    else
      # 返回 404 页面
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end

  def fetch_tweets
    service = TwitterMockService.new
    tweets_data = service.search_tweets

    p tweets_data["data"]

    if tweets_data
      tweets_data["data"]
      # tweets_data["data"]
      # redirect_to tweets_path, notice: "成功获取 #{tweets_data['data'].size} 条推文"
    else
      # redirect_to tweets_path, alert: "获取推文失败，请检查日志"
    end
  end
end
