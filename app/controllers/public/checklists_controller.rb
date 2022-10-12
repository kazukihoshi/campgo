class Public::ChecklistsController < ApplicationController
  def edit
  end

  def index
    #@camp = Camp.find(params[:id])
    @checklists = Checklist.all
    
  end

  def create
  end


  private

  def checklist_params
    params.require(:checklist).permit(:checklist_name, :comment)
  end

end
