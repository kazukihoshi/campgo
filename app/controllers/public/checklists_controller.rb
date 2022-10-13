class Public::ChecklistsController < ApplicationController
  def edit
  end

  def index
    #@category = Category.find(params[:category_id])
    #@checklists = @category.checklists
    @camp = Camp.find(params[:camp_id])
    @checklists = Checklist.all
    @checklist = Checklist.new
  end

  def create
  end


  private

  def checklist_params
    params.require(:checklist).permit(:checklist_name, :comment, :category_id)
  end

end
