class Micropost < ActiveRecord::Base
  
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  #===========================
  #お気に入り(逆引：マイクロポスト〜ユーザー)
  #===========================
  has_many :reverse_bookmarks_relationship, class_name:  "Bookmark",
                                            foreign_key: "post_id",
                                            dependent:   :destroy
  has_many :bookmarking_users, through: :reverse_bookmarks_relationship, source: :user
  
  #===========================
  #リツイート（正引）
  #===========================
  has_many :forward_retweets_relationship,  class_name:  "Retweet",
                                            foreign_key: "retweet_id",
                                            dependent:   :destroy
  has_many :retweeting_posts, through: :forward_retweets_relationship, source: :retweeted

  #===========================
  #リツイート（逆引）
  #===========================
  has_many :reverse_retweets_relationship,  class_name:  "Retweet",
                                            foreign_key: "retweeted_id",
                                            dependent:   :destroy
  has_many :retweeted_posts, through: :reverse_retweets_relationship, source: :retweet

  # 投稿をリツイートする
  def retweeting(other_post)
    forward_retweets_relationship.create(retweeted_id: other_post.id)
  end

  # リツイートを解除する
  def unretweeting(other_post)
    forward_retweets_relationship.find_by(retweeted_id: other_post.id).destroy
  end

  # 投稿をリツイートしてるかどうか？
  def retweeting?(other_post)
    retweeting_posts.include?(other_post)
  end

  # その投稿がそのユーザーにリツイートされているかどうか？
  def retweet_from_user?(other_post, other_user) 

  end
  
end
