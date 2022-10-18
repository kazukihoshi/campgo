class Public::CampsController < ApplicationController
  def new
    @camp = Camp.new
  end

  def show
    @camp = Camp.find(params[:id])
    @checklist = @camp.checklists.all
    #@checklist = Checklist.find(params[:id])
    #@checklist_manages = @checklist.checklist_manages
  end

  def edit
  end

  def create
    camp = current_user.camps.new(camp_params)
    camp.save!
    #byebug
    #camp.checklists
    Checklist.all.each do |checklist|
      ChecklistManage.create(camp_id: camp.id, user_id: current_user.id, checklist_id: checklist.id,)
    end
    redirect_to camp_checklists_path(camp.id)
    #camp_path(camp.id)
  end

  def index
    @camps = current_user.camps.all
  end

  def update_checklist_manage
     camp = Camp.find(params[:id])

     site_categories = params[:site_categories]
     cook_categories = params[:cook_categories]
     tent_categories = params[:tent_categories]


     unless site_categories == [""]

       site_categories.each do |checklist|
         unless checklist == ""
           ChecklistManage.find_by(checklist_id: checklist, camp_id: camp.id, user_id: current_user.id).update(is_active: true)
         end
       end
     end

     unless cook_categories == [""]

       cook_categories.each do |checklist|
         unless checklist == ""
           ChecklistManage.find_by(checklist_id: checklist, camp_id: camp.id, user_id: current_user.id).update(is_active: true)
         end
       end
     end


     unless tent_categories == [""]

       tent_categories.each do |checklist|
         unless checklist == ""
           ChecklistManage.find_by(checklist_id: checklist, camp_id: camp.id, user_id: current_user.id).update(is_active: true)
         end
       end
     end



  end


  private

  def camp_params
    params.require(:camp).permit(:schedule, :camp_site, :number_of_people)
  end

end
