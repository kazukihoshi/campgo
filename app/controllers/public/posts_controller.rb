class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    #tag_list = params[:post][:tag]から下記へ変更
    tag_list = params[:tag]
    if @post.save
      @post.save_tags(tag_list)
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @tag_list = params[:tag]
  end

  def show
  end

  def edit
  end


  private

  def post_params
    params.require(:post).permit(:post, :title, :camp_site, :post_image)
  end

end
