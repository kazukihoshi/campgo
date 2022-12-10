class Public::CampsController < ApplicationController
   before_action :authenticate_user!
  def new
    @camp = Camp.new
  end

  def show
    @camp = Camp.find(params[:id])
    @user = current_user
    #campに紐づいたchecklist_manages(is_active: true)を取得,checklist_idのみ
    active_checklist_ids = @camp.checklist_manages.where(is_active: true).pluck('checklist_id').uniq #[2,3,6,9]
    @checklists = Checklist.where(id: active_checklist_ids)
  end

  def create
    # @camp.errors.any?を使用するためインスタンス変数を使用
    @camp = current_user.camps.new(camp_params)
    #byebug
    if @camp.save
      #byebug
      Checklist.all.each do |checklist|
        ChecklistManage.create(camp_id: @camp.id, user_id: current_user.id, checklist_id: checklist.id,)
       flash[:notice] = "作成しました。"
      end
      redirect_to camp_checklists_path(@camp.id)
    else
      #byebug
      render :new
    end
  end

  def index
    @camps = current_user.camps.all.order(created_at: :desc).page(params[:page]).per(9)
  end

  def update_checklist_manage
     camp = Camp.find(params[:id])
     user = current_user

     site_categories = params[:site_categories]
     cook_categories = params[:cook_categories]
     tent_categories = params[:tent_categories]
     bonfire_categories = params[:bonfire_categories]
     others_categories = params[:others_categories]


     camp.checklist_manages.update_all(is_active: false)#update前に全てをfalseに変更、その後チェックしtrueに変更していく

     #byebug
     unless site_categories == [""]
       site_categories.each do |checklist|
        unless checklist == ""
          checklist_find = ChecklistManage.find_by(checklist_id: checklist, camp_id: camp.id, user_id: current_user.id)
          if checklist_find == nil  #新しく作成されたchecklist_manageはcreateされていないためnilであれば再度createする
            ChecklistManage.create(camp_id: camp.id, user_id: current_user.id, checklist_id: checklist, is_active: true)  #createすると同時にis_activeをtrueに変更
          else
            checklist_find.update(is_active: true)
          end
        end
       end
     end

     unless cook_categories == [""]
       cook_categories.each do |checklist|
        unless checklist == ""
          checklist_find = ChecklistManage.find_by(checklist_id: checklist, camp_id: camp.id, user_id: current_user.id)
          if checklist_find == nil
            ChecklistManage.create(camp_id: camp.id, user_id: current_user.id, checklist_id: checklist, is_active: true)
          else
            checklist_find.update(is_active: true)
          end
        end
       end
     end


     unless tent_categories == [""]

      tent_categories.each do |checklist|
       unless checklist == ""
        checklist_find = ChecklistManage.find_by(checklist_id: checklist, camp_id: camp.id, user_id: current_user.id)
          if checklist_find == nil
            ChecklistManage.create(camp_id: camp.id, user_id: current_user.id, checklist_id: checklist, is_active: true)
          else
            checklist_find.update(is_active: true)
          end
       end
      end
     end

     unless bonfire_categories == [""]

      bonfire_categories.each do |checklist|
       unless checklist == ""
        checklist_find = ChecklistManage.find_by(checklist_id: checklist, camp_id: camp.id, user_id: current_user.id)
          if checklist_find == nil
            ChecklistManage.create(camp_id: camp.id, user_id: current_user.id, checklist_id: checklist, is_active: true)
          else
            checklist_find.update(is_active: true)
          end
       end
      end
     end

     unless others_categories == [""]

       others_categories.each do |checklist|
        unless checklist == ""
          checklist_find = ChecklistManage.find_by(checklist_id: checklist, camp_id: camp.id, user_id: current_user.id)
            if checklist_find == nil
              ChecklistManage.create(camp_id: camp.id, user_id: current_user.id, checklist_id: checklist, is_active: true)
            else
             checklist_find.update(is_active: true)
            end
        end
       end
     end
     #byebug

     flash[:notice] = "作成しました"
     redirect_to camp_path(camp)
  end

  # camp/editの_list.html.erbでも使用
  def edit
    #byebug
    @camp = Camp.find(params[:id])
    @checklists = @camp.checklists.where(user_id: nil).or(Checklist.where(user_id: current_user.id))
    @checklist = @camp.checklists.new
    @active_checklist_ids = @camp.checklist_manages.where(is_active: true).pluck('checklist_id').uniq #[2,3,6,9]
  end

  def update
    @camp =Camp.find(params[:id])
    #byebug
    if @camp.update(camp_params)
      flash[:notice] = "更新しました"
      redirect_to camp_path(@camp.id)
    else
      @checklist = @camp.checklists.new
      @checklists = @camp.checklists.where(user_id: nil).or(Checklist.where(user_id: current_user.id))
      @active_checklist_ids = @camp.checklist_manages.where(is_active: true).pluck('checklist_id').uniq #[2,3,6,9]
      render :edit
    end
  end

  def destroy
    camp = Camp.find(params[:id])
    camp.destroy
    flash[:notice] = "削除しました"
    redirect_to camps_path
  end

  private

  def camp_params
    params.require(:camp).permit(:schedule, :camp_site, :number_of_people)
  end

  def checklist_manage_params
    params.require(:checklist_manage).permit(:camp_id, :checklist_id, :is_active,)
  end

end
