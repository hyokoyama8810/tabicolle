# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[destroy edit update]

  def index
    @following_user_posts = Post.where(user_id: current_user.following_user).paginate(page: params[:page], per_page: 5)
    @unfollowing_user_posts = Post.where.not(user_id: current_user.id).paginate(page: params[:page], per_page: 10)

    # タグ絞り込み
    if params[:tag_name]
      @tag_name_posts = Post.tagged_with(params[:tag_name].to_s).paginate(page: params[:page], per_page: 5)
    elsif params[:area]
      @area_posts = Post.where(area: params[:area].to_s).paginate(page: params[:page], per_page: 5)
    elsif params[:genre]
      @genre_posts = Post.where(genre: params[:genre].to_s).paginate(page: params[:page], per_page: 5)
    elsif params[:season]
      @season_posts = Post.where(season: params[:season].to_s).paginate(page: params[:page], per_page: 5)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.image.attach(params[:post][:image])
    if @post.save
      flash[:notice] = '投稿が作成されました｡'
      redirect_to current_user
    else
      render 'posts/new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to current_user
    else
      render action: :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to request.referer || root_url
    # [todo] 投稿詳細ページからのdestroyリクエスト後は､前ページにリダイレクトするのではなく､一覧ページに移動するようにしたい｡
  end

  private

    def post_params
      params.require(:post).permit(:content, :image, :area, :genre, :season, :tag_list)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      # redirect_to posts_url if @post.nil?
      # flash[:alert] = "他ユーザーの投稿の編集･削除はできません"
      if @post.nil? && current_user.admin = false
        flash[:alert] = '他ユーザーの投稿の編集･削除はできません'
        redirect_to posts_url
      end
    end
end
