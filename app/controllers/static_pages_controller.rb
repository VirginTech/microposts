class StaticPagesController < ApplicationController
  def home
    # Micropost.new(user_id: current_user.id)と同じ
    # has_many :microposts(user.rb)で生成される"build"を推奨
    @micropost = current_user.microposts.build if logged_in?
  end
end
