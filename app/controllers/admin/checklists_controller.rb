class Admin::ChecklistsController < ApplicationController
  def index
    @checklists = Checklist.all
   
    @category = Category.find(params[:category_id])
  end

  def create
    checklist = Checklist.new(checklist_params)
    @category = Category.find(params[:category_id])
    checklist.category = @category
    checklist.save
    #byebug
    redirect_to admin_category_checklists_path(@category)
  end
  
  def show
  end

  def edit
  end
  
  def destroy_all
    checked_date = params[:deletes].keys
    if Checklist.destroy_by(checked_date)
      redirect_to admin_category_checklists_path(@category)
    else
      render :index
    end 
  end
  
  private
  
  def checklist_params
    params.require(:checklist).permit(:checklist_name, :category_id, :comment)
  end

end
