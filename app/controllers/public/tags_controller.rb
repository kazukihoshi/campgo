class Public::TagsController < ApplicationController
   before_action :authenticate_user!

  def index
    #byebug
    @tag_list = Tag.all
    @comments = Comment.all
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.order(created_at: :desc)
  end

  def show
  end



  private
  def tag_params
    params.require(:tag).permit(:name)
  end



end
