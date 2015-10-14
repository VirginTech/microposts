class RetweetsController < ApplicationController
    before_action :logged_in_user

  def create
    @micropost = Micropost.new(user_id: current_user.id ,
                        origin_id: params[:retweeted_id], content: params[:content])
    #リツイートの保存
    @micropost.save
    flash[:success] = "リツイートされました!"

    #リツイート・リレーションシップ保存
    @retweet_post = Micropost.find(params[:retweeted_id])
    @micropost.retweeting(@retweet_post)
    
    redirect_to params[:redirect_url]
  end

  def destroy
  
    if !params[:delete_id].present?  #リツイート側なら
      @micropost = current_user.microposts.find_by(id: params[:id])
      #リレーションシップ削除（本来は必要なし。参照が切れるため自動で削除される。）
      #@retweet_post = @micropost.retweeting_posts.find_by(origin_id: params[:origin_id])
      #@micropost.unretweeting(@retweet_post)
    else #リツイート元なら
      @micropost = current_user.microposts.find_by(id: params[:delete_id])
    end
  
    #リツイート削除
    return redirect_to params[:redirect_url] if @micropost.nil?
    @micropost.destroy
    flash[:success] = "リツイート削除されました"
    
    redirect_to params[:redirect_url]
  end
  
end
