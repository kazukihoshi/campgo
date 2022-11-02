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
  end

  private

  def user_params
    params.require(:user).permit(:profile_image)
  end
end
