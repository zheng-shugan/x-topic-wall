class CreateTweets < ActiveRecord::Migration[8.0]
  def change
    create_table :tweets do |t|
      t.string :tweet_id, null: false
      t.text :text, null: false
      t.text :edit_history_tweet_ids

      t.timestamps
    end

    add_index :tweets, :tweet_id, unique: true
  end
end
