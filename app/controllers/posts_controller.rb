class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end

end
