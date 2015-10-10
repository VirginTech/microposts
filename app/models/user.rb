class User < ActiveRecord::Base
  
  #===========================
  #定数
  #===========================
  NAME_LABEL = "氏　名 :"
  ID_LABEL = "ＩＤ (Ｅメール) :"
  PASSWORD_LABEL = "パスワード (変更する場合のみ) :"

  AREA_LABEL = "地　域 :"
  PHONE_LABEL = "電話番号 :"
  PROFILE_LABEL = "プロフィール :"

  #===========================
  #バリデーション
  #===========================
  before_save { self.email = email.downcase }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\d{2,4}-\d{2,4}-\d{4}/

  validates :name, presence: true, length: { maximum: 50 }
  
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :profile, presence: false, length: { maximum: 300 }, on: :update

  validates :area, presence: false, length: { maximum: 50 }, on: :update

  validates :phone, presence: false, length: { maximum: 15 }, 
                    format: { with: VALID_PHONE_REGEX },on: :update


  has_secure_password
  
  has_many :microposts
  
  #===========================
  #フォロー／フォロワー
  #===========================
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
    # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  # フォローしているユーザーと自分のつぶやきを取得
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
  
  #===========================
  #お気に入り
  #===========================
  has_many :forward_bookmarks_relationship, class_name:  "Bookmark",
                                            foreign_key: "user_id",
                                            dependent:   :destroy
  has_many :bookmarking_posts, through: :forward_bookmarks_relationship, source: :post
  
  has_many :reverse_bookmarks_relationship, class_name:  "Bookmark",
                                            foreign_key: "post_id",
                                            dependent:   :destroy
  has_many :bookmarking_users, through: :reverse_bookmarks_relationship, source: :user
  
  # 投稿をブックマークする
  def bookmarking(other_post)
    forward_bookmarks_relationship.create(post_id: other_post.id)
  end

  # ブックマークを解除する
  def unbookmarking(other_post)
    forward_bookmarks_relationship.find_by(post_id: other_post.id).destroy
  end

  # 投稿をブックマークしてるかどうか？
  def bookmarking?(other_post)
    bookmarking_posts.include?(other_post)
  end
  
  
  
  
end