require 'faker'

# 清空现有数据
Tweet.destroy_all

# 创建 Mock 数据
10.times do |i|
  Tweet.create!(
    tweet_id: Faker::Number.unique.number(digits: 10).to_s,
    text: Faker::Lorem.sentence(word_count: 10),
    edit_history_tweet_ids: Array.new(rand(1..3)) { Faker::Number.unique.number(digits: 10).to_s }
  )
end

puts "Created #{Tweet.count} tweets."
