class Admin::CampsController < ApplicationController
  def index
    @camps = Camp.all
  end

  def show
    @camp = Camp.find(params[:id])

  end

  def search
  end

  private

  def camps_params
    params.require(:camp).permit(:schedule, :camp_site, :number_of_people)
  end

end
