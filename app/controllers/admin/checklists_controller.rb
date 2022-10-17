class Admin::ChecklistsController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @checklists = @category.checklists
    @checklist = Checklist.new

  end

  def create
    checklist = Checklist.new(checklist_params)
    category = Category.find(params[:category_id])
    checklist.category = category
    #byebug
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
      redirect_to admin_category_checklists_path(@category_id)
    else
      render :index
    end
  end

  private

  def checklist_params
    params.require(:checklist).permit(:checklist_name, :comment, :category_id)
  end

end
