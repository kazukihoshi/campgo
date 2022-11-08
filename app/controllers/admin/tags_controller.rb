class Admin::TagsController < ApplicationController

  def destroy
    post = Post.find(params[:post_id])
    # Tag.find_by(id: params[:id], post_id: post).destroy
    tag = post.tag_ids
    #byebug
    tag.destroy
    redirect_to admin_post_path(post.id)
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end



end
