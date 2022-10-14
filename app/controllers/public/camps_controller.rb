class Public::CampsController < ApplicationController
  def new
    @camp = Camp.new
  end

  def show
    @camp = Camp.find(params[:id])
  end

  def edit
  end

  def create
    camp = current_user.camps.new(camp_params)
    camp.save!
    #byebug
    #camp.checklists
    Checklist.all.each do |checklist|
      ChecklistManage.create(camp_id: camp.id, user_id: current_user.id, checklist_id: checklist.id)
    end
    redirect_to camp_checklists_path(camp.id)
    #camp_path(camp.id)
  end

  def index
    @camps = current_user.camps.all
  end


  private

  def camp_params
    params.require(:camp).permit(:schedule, :camp_site, :number_of_people)
  end

end
