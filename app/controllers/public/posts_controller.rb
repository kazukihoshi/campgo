class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      @post.save_tags(params[:tag])
      flash[:notice] = "投稿に成功しました"
      redirect_to post_path(@post.id)
      #byebug
    else
      render :new
    end
  end

  def index
    #byebug
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(9)
    @tag_list = Tag.all
    @comments = Comment.all
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

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user) #投稿に関連するコメントを取得
    @comment = current_user.comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:tag]
    #byebug
    if @post.update(post_params)
      @post.save_tags(tag_list)
      flash[:notice] = "投稿を編集しました"
      redirect_to post_path(@post.id)
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
    if params[:key_word].present?
      @posts = Post.search(params[:key_word])
    else
      @posts = Post.all.order(created_at: :desc)
    end
    @tag_lists = Tag.all
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(9)
  end

  def search_tag
    #byebug
    #検索結果画面でもタグ一覧表示
    #@tag_list=Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    @tags = Tag.all
    @posts=@tag.posts.page(params[:page]).per(9)
  end



  private

  def post_params
    params.require(:post).permit(:post, :title, :camp_site, post_images: [])  #post_imagesで複数の写真の許可
  end

end