class Admin::ChecklistsController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @checklists = @category.checklists.where(user_id: nil)
    @checklist = Checklist.new

    # if user.id == nil
    #   # user_idがcurrent_userのものを検索
    #   @checklist = Checklist.new
    # end

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
    checklist.update(checklist_params)
    redirect_to admin_category_checklists_path(category)
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


  def index_for_user
    #byebug
    @user = User.find(params[:user_id])
    #@checklist = Checklist.find(params[:id])
    #@checklist = Checklist.new
    @checklists = @user.checklists.where(user_id: @user.id)
    # userがログインしているかどうかの確認
    # if user_signed_in?
    #   # user_idがcurrent_userのものを検索
    #   @checklists = Checklist.where(user_id: current_user.id)
    # end
  end

  def destroy
    #byebug
    user = User.find(params[:user_id])
    #checklist = Checklist.new
    #byebug
    Checklist.find_by(user_id: user).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def checklist_params
    params.require(:checklist).permit(:checklist_name, :comment, :category_id)
  end

end
