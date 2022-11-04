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
    redirect_to admin_category_checklists_path(category)
  end

  def show
  end

  def edit
  end

  def destroy_all


    deletes_hash = params[:deletes].to_unsafe_hash
    deletes_hash.select {|_, v| v == "1" }.each do |k, _|
      checklist = Checklist.find(k)
      checklist.destroy
    end
    category = Category.find(params[:category_id])
    # checked_date = params[:deletes].keys
    # if Checklist.destroy_by(checked_date)
      redirect_to admin_category_checklists_path(category)
    # else
    #   render :index
    # end
  end

  private

  def checklist_params
    params.require(:checklist).permit(:checklist_name, :comment, :category_id)
  end

end
