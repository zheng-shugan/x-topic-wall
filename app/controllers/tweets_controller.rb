class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all()
    p @tweets
  end

  def show
    p params[:id]
    @tweet = Tweet.find_by!(tweet_id: params[:id])
  end
end
