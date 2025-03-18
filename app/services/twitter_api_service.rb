class TwitterApiService
  BASE_URL = "https://api.twitter.com/2/tweets/search/recent"

  def initialize
    @client = HTTP.headers(
      "Authorization" => "Bearer #{ENV['TWITTER_BEARER_TOKEN']}"
    )
  end

  def search_tweets(query: "#DeepSeek", max_results: 10, next_token: nil)
    params = {
      query: query,
      max_results: max_results,
      "tweet.fields": "edit_history_tweet_ids"
    }

    params[:next_token] = next_token if next_token.present?

    response = @client.get(BASE_URL, params: params)

    if response.status.success?
      JSON.parse(response.body.to_s)
    else
      Rails.logger.error("Twitter API Error: #{response.status} - #{response.body}")
      nil
    end
  rescue HTTP::Error => e
    Rails.logger.error("HTTP Error: #{e.message}")
    nil
  rescue JSON::ParserError => e
    Rails.logger.error("JSON Parse Error: #{e.message}")
    nil
  end

  def save_tweets(tweets_data)
    return unless tweets_data && tweets_data["data"]

    tweets_data["data"].each do |tweet_data|
      Tweet.create!(
        tweet_id: tweet_data["id"],
        text: tweet_data["text"],
        edit_history_tweet_ids: tweet_data["edit_history_tweet_ids"]
      )
    rescue ActiveRecord::RecordNotUnique
      # 忽略重复的推文
      next
    end
  end
end
