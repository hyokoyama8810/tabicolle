# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[destroy edit update]
  def index
    @courses = Course.all.paginate(page: params[:page], per_page: 3)
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      flash[:notice] = 'モデルコースが作成されました｡'
      redirect_to courses_url
    else
      render :new
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      flash[:notice] = 'モデルコースが編集されました'
      redirect_to course_url
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:notice] = 'モデルコースを削除しました'
    redirect_to courses_url
    # [todo] 投稿詳細ページからのdestroyリクエスト後は､前ページにリダイレクトするのではなく､一覧ページに移動するようにしたい｡
  end

  private

    def course_params
      params.require(:course).permit(:title, :date, :general_memo, logs_attributes: %i[spot time detailed_memo _destroy])
    end

    def correct_user
      @course = current_user.courses.find_by(id: params[:id])
      redirect_to courses_url, alert: '他ユーザーのモデルコースの編集･削除はできません' if @course.nil? && current_user.admin == false
    end
end
