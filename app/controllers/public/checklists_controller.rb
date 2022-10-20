class Public::ChecklistsController < ApplicationController
  def edit
  end

  def index
    #@category = Category.find(params[:category_id])
    #@checklists = @category.checklists
    @camp = Camp.find(params[:camp_id])
    @checklists = @camp.checklists
    @checklist = Checklist.new
    @checklist.checklist_manages.build
  end

  def create
    checklist = Checklist.new(checklist_params)
    camp = Camp.find(params[:camp_id])
    checklists = camp.checklists
    #puts current_user
    #category = Category.find(params[:category_id])
    #byebug
    #unless category == [""]
    checklist.user_id = current_user.id

    #byebug
    checklist.save

    # ChecklistManage.create(
    #     user_id: current_user.id,
    #     camp_id: camp.id,
    #     checklist_id: checklist.id
    #   )
    #end
    #byebug
    #redirect_to update_checklist_manage_camp_path(camp)
    redirect_to camp_checklists_path(camp)
    #creates_hash = params[:creates].to_unsafe_hash
    #creates_hash.select {|_, v| v == "1" }.each do |k, _|
      #checklist = Checklist.find(k)
      #checklist.save
    #end

    #checklist = Checklist.new(checklist_params)
    #Sbyebug
    #checklist.save
    #redirect_to root_path

    #checklist_manage = ChecklistManage.new(checklist_manage_params)
    #checklist_manage.save
    #redirect_to camp_checklists_path(camp.id)
    #Checklist.all.each do |checklist|
      #ChecklistManage.create(camp_id: camp.id, user_id: current_user.id, checklist_id: checklist.id,)
    #end
  end

  def new
    @checklist = Checklist.new
  end




  private

  def checklist_params
    params.require(:checklist).permit(:checklist_name, :comment, :category_id, checklist_manages_attributes: [:user_id, :camp_id])
  end

  def checklist_manage_params
    params.require(:checklist_manage).permit(:is_active)
  end

end
