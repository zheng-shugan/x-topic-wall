class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    p @tweets
  end

  def show
    p params[:id]
    @tweet = Tweet.find_by!(tweet_id: params[:id])
  rescue ActiveRecord::RecordNotFound
    render file: Rails.root.join("public/404.html"), status: :not_found, layout: false
  end
end
