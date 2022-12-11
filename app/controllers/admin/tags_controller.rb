class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    post = Post.find(params[:post_id])
    #byebug
    tag = Tag.find(params[:id])
    tag.destroy
    flash[:notice] = "タグを削除しました"
    redirect_to admin_post_path(post.id)
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end



end
