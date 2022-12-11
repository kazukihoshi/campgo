class Admin::CampsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @camps = Camp.all.order("created_at").page(params[:page]).per(10)
  end

  def show
    @camp = Camp.find(params[:id])
  end

  def destroy
    camp = Camp.find(params[:id])
    camp.destroy
    flash[:notice] = "キャンプをを削除しました"
    redirect_to admin_camps_path

  end

  def search
  end

  private

  def camps_params
    params.require(:camp).permit(:schedule, :camp_site, :number_of_people)
  end

end
