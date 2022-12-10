class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def edit
    @user = current_user
  end

  def update
    #パスワード変更後はログアウトされる
    @user = User.find(params[:id])
    #byebug
    if @user.update(user_params)
      #byebug
      flash[:notice] = "更新しました 再度ログインしてください"
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
     @user = current_user
     @posts = current_user.posts.all.order(created_at: :desc).page(params[:page]).per(9)
  end

  def unsubscribe
     @user = current_user
  end

  def withdraw
    user = current_user
    user.update(is_delete: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :email, :password, :password_confirmation)
  end
end
