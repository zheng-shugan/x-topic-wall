class Tweet < ApplicationRecord
  validates :tweet_id, presence: true, uniqueness: true
  validates :text, presence: true

  # 将 edit_history_tweet_ids 存储为 JSON 数组
  serialize :edit_history_tweet_ids, Array

  # 确保 tweet_id 是唯一的
  before_validation :ensure_tweet_id_uniqueness

  private

  def ensure_tweet_id_uniqueness
    if Tweet.exists?(tweet_id: tweet_id)
      throw(:abort)
    end
  end
end
