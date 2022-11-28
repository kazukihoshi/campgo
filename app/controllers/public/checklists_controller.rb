class Public::ChecklistsController < ApplicationController
  def new
    @checklist = Checklist.new
  end

  def index
    @camp = Camp.find(params[:camp_id])
    @checklist = Checklist.new
    @checklists = @camp.checklists.where(user_id: nil).or(Checklist.where(user_id: current_user.id))#user.idがnilとcurrent_userのものを抽出
    @checklist.checklist_manages.build
  end

  def index_for_camp
    @camp = Camp.find(params[:camp_id])
    #campに紐づいたchecklist_manages(is_active: true)を取得,checklist_idのみ
    active_checklist_ids = @camp.checklist_manages.where(is_active: true).pluck('checklist_id').uniq #[2,3,6,9]
    @checklists = Checklist.where(id: active_checklist_ids)
  end

  # ログインユーザーが作成したチェックリストの一覧
  def my_checklist_index
    @user = current_user
    @checklists = @user.checklists
    # userがログインしているかどうかの確認
    if user_signed_in?
      # user_idがcurrent_userのものを検索
      @checklists = Checklist.where(user_id: current_user.id)
    end
  end

  def create
    @checklist = Checklist.new(checklist_params)
    @camp = Camp.find(params[:camp_id])
    @checklists = @camp.checklists.where(user_id: nil).or(Checklist.where(user_id: current_user.id))#user.idがnilとcurrent_userのものを抽出
    #@checklists = @camp.checklists
    #puts current_user
    #category = Category.find(params[:category_id])
    #byebug
    #unless category == [""]
    @checklist.user_id = current_user.id

    #byebug
    if @checklist.save
      Checklist.all.each do |checklist|
        ChecklistManage.create(camp_id: @camp.id, user_id: current_user.id, checklist_id: @checklist.id)
        flash[:notice] = "アイテムを作成しました"
      end
       redirect_back(fallback_location: root_path)
    else
      referrer = Rails.application.routes.recognize_path(request.referrer)
      if referrer[:controller] == "public/checklists" && referrer[:action] == "index"
        render template: "public/checklists/index"
      elsif referrer[:controller] == "public/camps" && referrer[:action] == "edit"
        @active_checklist_ids = @camp.checklist_manages.where(is_active: true).pluck('checklist_id').uniq #[2,3,6,9]
        render template: "public/camps/edit"
      end
      # いずれでもない場合はテンプレートエラーになる。
      # urlはcamp/:id/checklistsとなるが問題なし
    end
    # ChecklistManage.create(
    #     user_id: current_user.id,
    #     camp_id: camp.id,
    #     checklist_id: checklist.id
    #   )
    #end
    #byebug
    #redirect_to update_checklist_manage_camp_path(camp)
    #redirect_to camp_checklists_path(camp)
    # redirect_toからredirect_backに変更
    #redirect_back(fallback_location: root_path)
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



  def edit
    # byebug
    # @camp = Camp.find(params[:camp_id])
    # @checklist = @camp.checklists.new
    # @checklists = @camp.checklists
    @user = current_user
    # @checklist = Checklist.where(user_id: current_user.id, id: checklist.id)
    @checklist = Checklist.find(params[:id])
    @checklist.user_id = current_user.id
    # @checklist = Checklist.find(params[:id])
  end


    #checklist_ids = @camp.checklist_manages.where(is_active: true).pluck('checklist_id').uniq #[2,3,6,9]
    #@checklists = Checklist.where(id: checklist_ids)

  def update
    checklist = Checklist.find(params[:id])
    user = current_user
    if checklist.update(checklist_params)
      flash[:notice] = "更新しました"
      redirect_to user_my_checklist_index_path(user.id)
    else
      render :edit
    end

  end




  def show
    @camp = Camp.find(params[:camp_id])
    #campに紐づいたchecklist_manages(is_active: true)を取得,checklist_idのみ
    active_checklist_ids = @camp.checklist_manages.where(is_active: true).pluck('checklist_id').uniq #[2,3,6,9]
    @checklists = Checklist.where(id: active_checklist_ids)



    #byebug

  end

  def update_checklist_manage
  end

  def destroy
    user = current_user
    checklist = Checklist.find(params[:id])
    checklist.destroy
    redirect_to user_my_checklist_index_path(user.id)
  end



  private

  def checklist_params
    params.require(:checklist).permit(:checklist_name, :comment, :category_id, checklist_manages_attributes: [:user_id, :camp_id])
  end

  def checklist_manage_params
    params.require(:checklist_manage).permit(:is_active)
  end

end
