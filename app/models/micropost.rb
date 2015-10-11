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
  
end
