class Public::UsersController < ApplicationController
  def index
  end

  def edit
    @user = current_user
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:profile_image)
  end
end
