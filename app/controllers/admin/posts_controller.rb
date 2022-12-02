class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.order("created_at").page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user) #投稿に関連するコメントを取得
    #@comment = current_user.comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
    @tags = @post.tags.includes(:user)
  end

  def edit
  end

  def update
  end

  def destroy
    #byebug
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end


end
