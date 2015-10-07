class StaticPagesController < ApplicationController
  def home
    if logged_in?
    # Micropost.new(user_id: current_user.id)と同じ
    # has_many :microposts(user.rb)で生成される"build"を推奨
      @micropost = current_user.microposts.build

      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
end
