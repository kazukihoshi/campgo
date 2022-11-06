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
      flash[:notice] = "投稿に成功しました。"
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page])
    # @posts = Post.page(params[:page])
    @tag_list = params[:tag]
    @comments = Comment.all
#byebug
    #検索
    # if params[:key_word].present?
    #   @posts = Post.posts_serach(params[:key_word])
    # # elsif params[:tag_id].present?
    # #   @tag = Tag.find(params[:tag_id])
    # #   @posts = @tag.posts.order(created_at: :desc)
    # else
    #   @posts = Post.all.order(created_at: :desc)
    # end
    #@tag_lists = Tag.all
    # @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
  end

#   def search
# byebug
#     @posts = Post.search(params[:keyword])
#     # redirect_to posts_path
#   end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user) #投稿に関連するコメントを取得
    @comment = current_user.comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    tag_list = params[:tag]
    if post.update(post_params)
      post.save_tags(tag_list)
      redirect_to post_path(post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end


  def search
    #byebug
    # @posts = Post.search(params[:key_word])
    #redirect_to posts_path
    if params[:key_word].present?
      @posts = Post.search(params[:key_word])
      #flash[:notice] = "検索結果を表示します。"
    # elsif params[:tag_id].present?
    #   @tag = Tag.find(params[:tag_id])
    #   @posts = @tag.posts.order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
      #flash[:notice] = "検索結果がありません"
    end
    @tag_lists = Tag.all
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
  end


  private

  def post_params
    params.require(:post).permit(:post, :title, :camp_site, post_images: [])  #post_imagesで複数の写真の許可
  end

end
