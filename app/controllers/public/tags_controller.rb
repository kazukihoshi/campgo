class Public::TagsController < ApplicationController

  def index
    #@posts = Post.all.order(created_at: :desc).page(params[:page])
    #byebug
    @tag_list = Tag.all
    @comments = Comment.all
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.order(created_at: :desc)
  end



  private
  def tag_params
    params.require(:tag).permit(:name)
  end



end
