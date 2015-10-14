class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.references :retweet, index: true
      t.references :retweeted, index: true

      t.timestamps null: false
      t.index [:retweet_id, :retweeted_id], unique: true # この行を追加
    end
  end
end
