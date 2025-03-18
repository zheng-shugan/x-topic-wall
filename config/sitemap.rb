SitemapGenerator::Sitemap.create do
  add tweets_path, priority: 0.8, changefreq: 'daily'

  Tweet.find_each do |tweet|
    add tweet_path(tweet.tweet_id), priority: 0.6, changefreq: 'weekly'
  end
end
