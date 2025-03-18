require "net/http"
require "uri"
require "dotenv/load"

# 配置请求参数
url = URI("https://api.twitter.com/2/tweets/search/recent")

params = { max_results: 1 }
url.query = URI.encode_www_form(params)

# 获取环境变量
TOKEN = ENV.fetch("TWEET_TOKEN") do
  if Rails.env.production?
    raise "Missing X API token!"
  else
    "dev_test_token" # 开发环境测试用
  end
end

def request_tweets(topic)
  if topic.nil?
    puts "Please provide a topic to search for."
    return
  end

  # 如果没有以 # 开头，则添加
  if !topic.start_with?("#")
    topic = "##{topic}"
  end

  # 设置请求头
  headers = {
    "Authorization" => "Bearer #{TOKEN}"
  }

  queryString = {
    "max_results" => 10,
    "query" => topic # 搜索关键词
  }

  url.query = URI.encode_www_form(queryString)
  req = Net::HTTP::Get.new(url, headers)
  res = Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
    http.request(req)
  end

  case res
  when Net::HTTPSuccess
    puts res.body
  else
    puts "Request failed: #{res.code} #{res.message}"
  end
end
