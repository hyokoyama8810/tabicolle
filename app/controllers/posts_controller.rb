class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 5)
    #タグ絞り込み
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").paginate(page: params[:page], per_page: 5)
    elsif params[:area]
      @posts = Post.where(area: "#{params[:area]}").paginate(page: params[:page], per_page: 5)
    elsif params[:genre]
      @posts = Post.where(genre: "#{params[:genre]}").paginate(page: params[:page], per_page: 5)
    elsif params[:season]
      @posts = Post.where(season: "#{params[:season]}").paginate(page: params[:page], per_page: 5)
    end

  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.image.attach(params[:post][:image])
    if @post.save
      flash[:notice] = "投稿が作成されました｡"
      redirect_to posts_url
    else
      render 'posts/new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to posts_url
    else
      render action: :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to request.referrer || root_url
    # [todo] 投稿詳細ページからのdestroyリクエスト後は､前ページにリダイレクトするのではなく､一覧ページに移動するようにしたい｡

  end

  private

    def post_params
      params.require(:post).permit(:content, :image, :area, :genre, :season, :tag_list)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

end
