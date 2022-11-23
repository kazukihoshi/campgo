class Admin::CampsController < ApplicationController
  def index
    @camps = Camp.all
  end

  def show
    @camp = Camp.find(params[:id])
  end

  def destroy
    camp = Camp.find(params[:id])
    camp.destroy
    redirect_to admin_camps_path

  end

  def search
  end

  private

  def camps_params
    params.require(:camp).permit(:schedule, :camp_site, :number_of_people)
  end

end
