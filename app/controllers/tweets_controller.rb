class TweetsController < ApplicationController
  def index
    @tweets = fetch_tweets
  end

  def show
    @tweet = params["tweet"]
    # @tweet = Tweet.find_by!(tweet_id: params[:id])
    # rescue ActiveRecord::RecordNotFound
    # render file: Rails.root.join("public/404.html"), status: :not_found, layout: false
  end

  def fetch_tweets
    service = TwitterMockService.new
    tweets_data = service.search_tweets

    p tweets_data["data"]

    if tweets_data
      tweets_data["data"]
      # tweets_data["data"]
      # service.save_tweets(tweets_data)
      # redirect_to tweets_path, notice: "成功获取 #{tweets_data['data'].size} 条推文"
    else
      # redirect_to tweets_path, alert: "获取推文失败，请检查日志"
    end
  end
end
