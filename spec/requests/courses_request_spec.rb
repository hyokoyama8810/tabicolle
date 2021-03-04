# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  before do
    @user = create(:user)
    @course = create(:course, user_id: @user.id)
  end

  describe 'GET #index' do
    context '認証済みのユーザーとして' do
      it '200レスポンスを返すこと' do
        sign_in @user
        get courses_path
        expect(response).to have_http_status '200'
      end
    end

    context '認証していないユーザーとして' do
      it '302レスポンスを返すこと' do
        get courses_path
        expect(response).to have_http_status '302'
      end

      it 'サインイン画面にリダイレクトされること' do
        get courses_path
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'GET #show' do
    context '認証済みのユーザーとして' do
      it '200レスポンスを返すこと' do
        sign_in @user
        get course_path(@course.id)
        expect(response).to have_http_status '200'
      end
    end

    context '認証していないユーザーとして' do
      it '302レスポンスを返すこと' do
        get course_path(@course.id)
        expect(response).to have_http_status '302'
      end

      it 'サインイン画面にリダイレクトされること' do
        get course_path(@course.id)
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'GET #new' do
    context '認証済みのユーザーとして' do
      it '200レスポンスを返すこと' do
        sign_in @user
        get new_course_path
        expect(response).to have_http_status '200'
      end
    end

    context '認証していないユーザーとして' do
      it '302レスポンスを返すこと' do
        get new_course_path
        expect(response).to have_http_status '302'
      end

      it 'サインイン画面にリダイレクトされること' do
        get new_course_path
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'course #create' do
    context '認証済みのユーザーとして' do
      it '投稿が作成されること' do
        course_params = attributes_for(:course)
        sign_in @user
        expect {
          post courses_path, params: { course: course_params }
        }.to change(@user.courses, :count).by(1)
      end
    end

    context '認証していないユーザーとして' do
      it '投稿が登録されないこと' do
        course_params = attributes_for(:course)
        expect {
          post courses_path, params: { course: course_params }
        }.to change(@user.courses, :count).by(0)
      end

      it 'サインイン画面にリダイレクトされること' do
        course_params = attributes_for(:course)
        post courses_path, params: { course: course_params }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'GET #edit' do
    context '認証済みのユーザーとして' do
      it '200レスポンスを返すこと' do
        sign_in @user
        get edit_course_path @course
        expect(response).to have_http_status '200'
      end
    end

    context '認証していないユーザーとして' do
      it '302レスポンスを返すこと' do
        get edit_course_path @course
        expect(response).to have_http_status '302'
      end

      it 'サインイン画面にリダイレクトされること' do
        get edit_course_path @course
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'DELETE #destroy' do
    context '認証済みのユーザーとして' do
      it 'リクエストが成功すること' do
        sign_in @user
        delete course_url @course
        expect(response).to have_http_status '302'
      end

      it '投稿が削除されること' do
        sign_in @user
        expect {
          delete course_url @course
        }.to change(Course, :count).by(-1)
      end

      it 'ユーザー一覧にリダイレクトすること' do
        sign_in @user
        delete course_url @course
        expect(response).to redirect_to(courses_url)
      end
    end

    context '認証していないユーザーとして' do
      it '投稿が削除されず､投稿数が変わらないこと' do
        expect {
          delete course_url @course
        }.to change(Course, :count).by(0)
      end

      it 'サインイン画面にリダイレクトすること' do
        delete course_url @course
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
