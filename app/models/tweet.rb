class Tweet < ApplicationRecord
  # 替换 serialize 为 attribute
  attribute :edit_history_tweet_ids, :json, default: []

  validates :tweet_id, presence: true, uniqueness: true
  validates :text, presence: true

  private
end
