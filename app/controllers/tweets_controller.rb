class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all()
  end

  def show
    @tweet = Tweet.find_by!(tweet_id: params[:id])
  end
end
