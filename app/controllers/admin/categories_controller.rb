class Admin::CategoriesController < ApplicationController
  def index
    @category = Category.new
    @categories = Category.all
  end

  def destroy_all
    # 1を探して(チェックされているもの),1のkeyを取得する(17が取得できる)
  #  きkeyのかてごりを削除する
    #byebug
    deletes_hash = params[:deletes].to_unsafe_hash
    deletes_hash.each do |h|
      if h[1] == 1
        h.keys
      #puts h[0]
      #puts h[1]
    end
    checked_date = params[:deletes].keys
    # if Category.destroy_by(checked_date)
      # redirect_to admin_categories_path
    # else
      # render :index
    # end
    #category = Category.find(params[:id])
    #category.destroy
    #redirect_to admin_categories_path
  end

  def create
    category = Category.new(category_params)
    category.save
    redirect_to admin_categories_path
  end

  def update
    category = Category.find(params[:id])
    category.update(category_params)
    redirect_to admin_categories_path
  end

  def edit
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end


end
