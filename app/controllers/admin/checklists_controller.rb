class Admin::ChecklistsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @category = Category.find(params[:category_id])
    @checklists = @category.checklists.where(user_id: nil)
    @checklist = Checklist.new

  end

  def create
    @checklist = Checklist.new(checklist_params)
    @category = Category.find(params[:category_id])
    @checklist.category = @category
    #byebug
    if @checklist.save
    #byebug
      flash[:notice] = "作成しました"
      redirect_to admin_category_checklists_path(@category)
    else
      redirect_back(fallback_location: root_path)
    end

  end

  def show
    @camp = Camp.find(params[:id])
    @checklists = Checklist.find(params[:id])
  end

  def edit
    @checklist = Checklist.find(params[:id])
    @category = Category.find(params[:category_id])
  end

  def update
    checklist = Checklist.find(params[:id])
    category = Category.find(params[:category_id])
    if checklist.update(checklist_params)
      flash[:notice] = "更新しました"
      redirect_to admin_category_checklists_path(category)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy_all
    deletes_hash = params[:deletes].to_unsafe_hash
    deletes_hash.select {|_, v| v == "1" }.each do |k, _|
      checklist = Checklist.find(k)
      checklist.destroy
    end
    category = Category.find(params[:category_id])
    flash[:notice] = "削除しました"
    redirect_to admin_category_checklists_path(category)
  end


  def index_for_user
    #byebug
    @user = User.find(params[:user_id])

    @checklists = @user.checklists.where(user_id: @user.id)
  end

  def destroy
    #byebug
    user = User.find(params[:user_id])
    #byebug
    Checklist.find_by(user_id: user).destroy
    flash[:notice] = "削除しました"
    redirect_back(fallback_location: root_path)
  end

  private

  def checklist_params
    params.require(:checklist).permit(:checklist_name, :comment, :category_id)
  end

end
