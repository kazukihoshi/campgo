class Public::ChecklistsController < ApplicationController
   before_action :authenticate_user!
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
    #byebug
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
  end

  def edit
    # byebug
    # @camp = Camp.find(params[:camp_id])
    @user = current_user
    @checklist = Checklist.find(params[:id])
    #@checklists = Checklist.where(user_id: current_user.id)#user.idがcurrent_userのものを抽出
    #@checklist.user_id = current_user.id
  end

  def update
    @checklist = Checklist.find(params[:id])
    @user = current_user
    @checklist.user = @user
    #byebug
    if @checklist.update(checklist_params)
      flash[:notice] = "更新しました"
      redirect_to user_my_checklist_index_path(@user.id)
    else
      #renderした際にformがインスタンス変数のためインスタンス変数にする
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
    flash[:notice] = "削除しました"
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
