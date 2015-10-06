class UsersController < ApplicationController
  
  before_action :set_profile, only: [:edit, :update]
  
  def followings
    @user = User.find(session[:user_id])
    @followings = @user.following_users
  end
  
  def followers
    @user = User.find(session[:user_id])
    @followers = @user.follower_users
  end
  
  def edit
  end
  
  def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts
  end
  
  def new
    @user = User.new
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to @user
      flash[:success] = "プロフィールを変更しました。"
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      session[:user_id] = @user.id
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:profile,:phone,:area)
  end
  
  def set_profile
    @user = User.find(params[:id])
  end
  
end