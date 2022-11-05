class Public::UsersController < ApplicationController
  def index
  end

  def edit
    @user = current_user
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  def show
     @user = current_user
     @posts = current_user.posts.all
  end

  def unsubscribe
     @user = current_user
  end

  def withdraw
    user = current_user
    user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :email)
  end
end
