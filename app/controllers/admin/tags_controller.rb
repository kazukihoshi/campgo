class Admin::TagsController < ApplicationController

  def destroy
    post = Post.find(params[:post_id])
    #byebug
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_post_path(post.id)
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end



end
