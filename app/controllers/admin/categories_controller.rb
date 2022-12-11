class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @category = Category.new
    @categories = Category.all
  end

  def destroy_all
    # 1を探して(チェックされているもの),1のkeyを取得する(17が取得できる)
  # keyのかてごりを削除する
    #byebug
    deletes_hash = params[:deletes].to_unsafe_hash
    deletes_hash.select {|_, v| v == "1" }.each do |k, _|
      category = Category.find(k)
      category.destroy
    end
    flash[:notice] = "削除しました"
    redirect_to admin_categories_path
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "作成しました"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
      #redirect_back(fallback_location: root_path)
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "更新しました"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end

end
