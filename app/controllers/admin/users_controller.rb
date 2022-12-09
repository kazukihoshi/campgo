class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order("created_at").page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    #byebug
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新しました"
     redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :is_delete)
  end

end
