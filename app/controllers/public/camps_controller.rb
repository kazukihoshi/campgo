class Public::CampsController < ApplicationController
  def new
    @camp = Camp.new
  end

  def show
  end

  def edit
  end

  def create
    camp = Camp.new(camp_params)
    camp.save
    redirect_to edit_camp_checklist_path(camp_id)

  end


  private

  def camp_params
    params.require(:camp).permit(:schedule, :camp_site, :number_of_people)
  end

end
