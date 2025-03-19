class TweetsController < ApplicationController
  def index
    @tweets = []
  end

  def show
    # 如果没有 tweet 参数
    if params["tweet"]
      @tweet = params["tweet"]
    else
      # 返回 404 页面
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end

  def fetch_mock_tweets
    service = TwitterMockService.new
    query = params[:query] || "#DeepSeek"  # 如果没有搜索参数，使用默认值
    tweets_data = service.search_tweets(query: query)
    @tweets = tweets_data ? tweets_data["data"] : []

    respond_to do |format|
      format.html { render partial: "tweets/list", locals: { tweets: @tweets } } # 默认 HTML 格式
      format.js { render partial: "tweets/list", locals: { tweets: @tweets } }
    end
  end

  def fetch_tweets
    service = TwitterApiService.new
    query = params[:query] || "#DeepSeek"  # 如果没有搜索参数，使用默认值
    tweets_data = service.search_tweets(query: query)
    @tweets = tweets_data ? tweets_data["data"] : []

    respond_to do |format|
      format.html { render partial: "tweets/list", locals: { tweets: @tweets } } # 默认 HTML 格式
      format.js { render partial: "tweets/list", locals: { tweets: @tweets } }
    end
  end
end
