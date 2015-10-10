class BookmarksController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:post_id])
    current_user.bookmarking(@micropost)
    redirect_to params[:redirect_url]
  end

  def destroy
    @micropost = current_user.bookmarking_posts.find(params[:id])
    current_user.unbookmarking(@micropost)
    redirect_to params[:redirect_url]
  end
  
end
