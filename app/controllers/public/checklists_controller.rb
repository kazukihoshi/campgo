class Public::ChecklistsController < ApplicationController
  def edit
  end

  def index
    @camp = current_user.camps.new(camp_params)
    @checklist = Checklist.find(params[:id])
  end


  private

  def checklist_params
    params.require(:checklist).permit(:checklist_name, :comment)
  end

end
