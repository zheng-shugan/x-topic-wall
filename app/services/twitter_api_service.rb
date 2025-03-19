require "typhoeus"
require "json"

class TwitterApiService
  BASE_URL = "https://api.twitter.com/2/tweets/search/recent"

  def initialize
    @bearer_token = ENV["BEARER_TOKEN"]
  end

  def search_tweets(query: "#DeepSeek", max_results: 10, start_time: nil, end_time: nil, expansions: nil, tweet_fields: nil, user_fields: nil)
    # 构建查询参数
    query_params = {
      "query": query,
      "max_results": max_results,
      "tweet.fields": tweet_fields || "attachments,author_id,conversation_id,created_at,entities,id,lang",
      "user.fields": user_fields || "description"
    }

    query_params["start_time"] = start_time if start_time.present?
    query_params["end_time"] = end_time if end_time.present?
    query_params["expansions"] = expansions if expansions.present?

    # 发起请求
    response = make_request(BASE_URL, query_params)

    if response.success?
      JSON.parse(response.body)
    else
      Rails.logger.error("Twitter API Error: #{response.code} - #{response.body}")
      nil
    end
  rescue JSON::ParserError => e
    Rails.logger.error("JSON Parse Error: #{e.message}")
    nil
  end

  private

  def make_request(url, params)
    options = {
      method: :get,
      headers: {
        "User-Agent": "v2RecentSearchRuby",
        "Authorization": "Bearer #{@bearer_token}"
      },
      params: params
    }

    Typhoeus::Request.new(url, options).run
  end
end
