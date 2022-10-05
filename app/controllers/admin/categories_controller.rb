class Admin::CategoriesController < ApplicationController
  def index
    @category = Category.new
  end


end
