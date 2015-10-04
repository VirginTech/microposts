class User < ActiveRecord::Base
  
  #定数
  NAME_LABEL = "氏　名 :"
  ID_LABEL = "ＩＤ (Ｅメール) :"
  PASSWORD_LABEL = "パスワード (変更する場合のみ) :"

  AREA_LABEL = "地　域 :"
  PHONE_LABEL = "電話番号 :"
  PROFILE_LABEL = "プロフィール :"

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
end