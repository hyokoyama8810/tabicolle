class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿が作成されました｡"
      redirect_to posts_url
    else
      render 'posts/new'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

end
