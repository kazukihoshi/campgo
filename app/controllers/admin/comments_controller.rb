class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

    def destroy
      post = Post.find(params[:post_id])
      Comment.find_by(id: params[:id], post_id: post).destroy
      redirect_to admin_post_path(post.id)
    end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end

end