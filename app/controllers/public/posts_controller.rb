class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @tag_list = Tag.all
  end

  def show
  end

  def edit
  end
end
