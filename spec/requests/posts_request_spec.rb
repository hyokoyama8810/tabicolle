# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before do
    @user = create(:user)
    @post = create(:post, user_id: @user.id)
  end

  describe 'GET index' do
    context '認証済みのユーザーとして' do
      it '200レスポンスを返すこと' do
        sign_in @user
        get posts_path
        expect(response).to have_http_status '200'
      end
    end

    context '認証していないユーザーとして' do
      it '302レスポンスを返すこと' do
        get posts_path
        expect(response).to have_http_status '302'
      end

      it 'サインイン画面にリダイレクトされること' do
        get posts_path
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'GET new' do
    context '認証済みのユーザーとして' do
      it '200レスポンスを返すこと' do
        sign_in @user
        get new_post_path
        expect(response).to have_http_status '200'
      end
    end

    context '認証していないユーザーとして' do
      it '302レスポンスを返すこと' do
        get new_post_path
        expect(response).to have_http_status '302'
      end

      it 'サインイン画面にリダイレクトされること' do
        get new_post_path
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'POST create' do
    context '認証済みのユーザーとして' do
      it '投稿が作成されること' do
        post_params = attributes_for(:post)
        sign_in @user
        expect {
          post posts_path, params: { post: post_params }
        }.to change(@user.posts, :count).by(1)
      end
    end

    context '認証していないユーザーとして' do
      it '投稿が登録されないこと' do
        post_params = attributes_for(:post)
        expect {
          post posts_path, params: { post: post_params }
        }.to change(@user.posts, :count).by(0)
      end

      it 'サインイン画面にリダイレクトされること' do
        post_params = attributes_for(:post)
        post posts_path, params: { post: post_params }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'GET edit' do
    context '認証済みのユーザーとして' do
      it '200レスポンスを返すこと' do
        sign_in @user
        get edit_post_path @post
        expect(response).to have_http_status '200'
      end
    end

    context '認証していないユーザーとして' do
      it '302レスポンスを返すこと' do
        get edit_post_path @post
        expect(response).to have_http_status '302'
      end

      it 'サインイン画面にリダイレクトされること' do
        get edit_post_path @post
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'DELETE destroy' do
    context '認証済みのユーザーとして' do
      it 'リクエストが成功すること' do
        sign_in @user
        delete post_url @post
        expect(response.status).to eq 302
      end

      it '投稿が削除されること' do
        sign_in @user
        expect {
          delete post_url @post
        }.to change(Post, :count).by(-1)
      end

      it 'ユーザー一覧にリダイレクトすること' do
        sign_in @user
        delete post_url @post
        expect(response).to redirect_to(request.referer || root_url)
      end
    end

    context '認証していないユーザーとして' do
      it '投稿が削除されること' do
        expect {
          delete post_url @post
        }.to change(Post, :count).by(0)
      end

      it 'サインイン画面にリダイレクトすること' do
        delete post_url @post
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
