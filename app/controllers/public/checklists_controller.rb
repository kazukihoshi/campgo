class Public::ChecklistsController < ApplicationController
  def edit
  end

  def index
    #@category = Category.find(params[:category_id])
    #@checklists = @category.checklists
    @camp = Camp.find(params[:camp_id])
    @checklists = @camp.checklists
    @checklist = Checklist.new
  end

  def create

    creates_hash = params[:creates].to_unsafe_hash
    creates_hash.select {|_, v| v == "1" }.each do |k, _|
      checklist = Checklist.find(k)
      checklist.save
    end

    #checklist = Checklist.new(checklist_params)
    byebug
    #checklist.save
    redirect_to root_path

    #checklist_manage = ChecklistManage.new(checklist_manage_params)
    #checklist_manage.save
    #redirect_to camp_checklists_path(camp.id)
    #Checklist.all.each do |checklist|
      #ChecklistManage.create(camp_id: camp.id, user_id: current_user.id, checklist_id: checklist.id,)
    #end
  end


  private

  def checklist_params
    params.require(:checklist).permit(:checklist_name, :comment, :category_id,)
  end

  def checklist_manage_params
    params.require(:checklist_manage).permit(:is_active)
  end

end
