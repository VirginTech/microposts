class UsersController < ApplicationController
  
  before_action :set_profile, only: [:edit, :update, :following, :follower, :bookmarking]
  
  #====================================
  #ユーザー一覧
  #====================================
  def index
    #編集すると順番が入れ替わる
    #@users=User.all.page(params[:page]).per(5)
    
    #順番を固定する
    @users = User.order(:created_at).page(params[:page]).per(5)
    @user = User.new
  end
  
  #====================================
  #ブックマーク取得（メンバールーティング）
  #====================================
  def bookmarking
    @user = User.find(params[:id])
    @bookmarkings=@user.bookmarking_posts.page(params[:page]).per(5)
  end

  #====================================
  #フォロー／フォロワー取得（メンバールーティング）
  #====================================
  def following
    @user = User.find(params[:id]) 
    #ページネーション付き
    @followings = @user.following_users.page(params[:page]).per(5)
  end
  
  def follower
    @user = User.find(params[:id]) 
    #ページネーション付き
    @followers = @user.follower_users.page(params[:page]).per(5)
  end
  
  #===============================
  #自分のみのフォロー／フォロワー取得
  #===============================
  #def followings
  #  @user = User.find(session[:user_id])
  #  @followings = @user.following_users
  #end
  #
  #def followers
  #  @user = User.find(session[:user_id])
  #  @followers = @user.follower_users
  #end
  #===============================
  
  def edit
  end
  
  def show # 追加
   @user = User.find(params[:id])
   #降順（ページネーション付き）
   @microposts = @user.microposts.order(created_at: :desc).page(params[:page]).per(7)
  end
  
  def new
    @user = User.new
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to @user
      flash[:success] = t('flash_edit_success')
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "#{@user.name} #{t('flash_welcome')}"
      session[:user_id] = @user.id
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:profile,:phone,:area,:avatar)
  end
  
  def set_profile
    @user = User.find(params[:id])
  end
  
end