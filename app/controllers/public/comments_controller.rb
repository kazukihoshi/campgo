class Public::CommentsController < ApplicationController
  def edit
  end

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    if comment.save
      redirect_to post_path(post.id)
      #request.referer, notice: "投稿しました" #遷移前のURLの取得
    else
      flash[:danger] = "コメントに失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    Comment.find_by(id: params[:id], post_id: post).destroy
    redirect_to post_path(post.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end



end
