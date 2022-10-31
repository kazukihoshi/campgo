class Public::CommentsController < ApplicationController
  def edit
  end

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    if comment.save
      redirect_to post_path
      #request.referer, notice: "投稿しました" #遷移前のURLの取得
    #else
      #flash[:danger] = "投稿に失敗しました"
      #redirect_back(fallback_location: root_path)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end



end
