class StaticPagesController < ApplicationController
  def home
    if logged_in?
    # Micropost.new(user_id: current_user.id)と同じ
    # has_many :microposts(user.rb)で生成される"build"を推奨
      @micropost = current_user.microposts.build
      
      #降順（ページネーション付き）
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(7)
      #昇順（ページネーション付き）
      #@feed_items = current_user.feed_items.includes(:user).order(:created_at).page(params[:page]).per(7)
    end
  end
end
