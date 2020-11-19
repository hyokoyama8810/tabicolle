# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before do
    @user = create(:user)
  end

  describe 'GET #show' do
    context '認証済みのユーザーとして' do
      it 'リクエストが成功すること' do
        sign_in @user
        get user_url @user
        expect(response).to have_http_status '200'
      end

      it 'ユーザー名が表示されていること' do
        sign_in @user
        get user_url @user
        expect(response.body).to include @user.name
      end
    end

    context '認証していないユーザーとして' do
      it 'リクエストが失敗すること' do
        get user_url @user
        expect(response).to have_http_status '302'
      end

      it 'サインイン画面にリダイレクトされること' do
        get user_url @user
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'GET #new' do
    context '認証済みのユーザーとして' do
      it 'マイページにリダイレクトされる' do
        sign_in @user
        get new_user_registration_url
        expect(response).to redirect_to user_url @user
      end
    end

    context '認証していないユーザーとして' do
      it 'リクエストが成功すること' do
        get new_user_registration_url
        expect(response).to have_http_status '200'
      end
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post user_registration_url, params: { user: attributes_for(:user) }
        expect(response).to have_http_status '302'
      end

      it 'ユーザーが登録されること' do
        expect {
          post user_registration_url, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'リダイレクトすること' do
        post user_registration_url, params: { user: attributes_for(:user) }
        expect(response).to redirect_to root_url
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_url, params: { user: attributes_for(:user, name: nil) }
        expect(response).to have_http_status '200'
      end

      it 'エラーが表示されること' do
        post user_registration_url, params: { user: attributes_for(:user, name: nil) }
        expect(response.body).to include '件のエラーが発生したため ユーザー は保存されませんでした'
      end
    end

    context '名前が無効な場合' do
      it '空欄のときユーザーが登録されないこと' do
        expect {
          post user_registration_url, params: { user: attributes_for(:user, name: nil) }
        }.not_to change(User, :count)
      end
    end

    context 'メールアドレスが無効な場合' do
      it '空欄のときユーザーが登録されないこと' do
        expect {
          post user_registration_url, params: { user: attributes_for(:user, email: nil) }
        }.not_to change(User, :count)
      end

      it 'すでに使われているときユーザーが登録されないこと' do
        expect {
          post user_registration_url, params: { user: attributes_for(:user, email: @user.email) }
        }.not_to change(User, :count)
      end
    end

    context 'パスワードが無効な場合' do
      it '6文字未満のときユーザーが登録されないこと' do
        expect {
          post user_registration_url, params: { user: attributes_for(:user, password: 'a' * 5, password_confirmation: 'a' * 5) }
        }.not_to change(User, :count)
      end
    end
  end

  describe 'GET #edit' do
    context '認証済みのユーザーとして' do
      it 'リクエストが成功すること' do
        sign_in @user
        get edit_user_registration_url @user
        expect(response).to have_http_status '200'
      end

      it 'ユーザー名が表示されていること' do
        sign_in @user
        get edit_user_registration_url @user
        expect(response.body).to include @user.name
      end

      it 'メールアドレスが表示されていること' do
        sign_in @user
        get edit_user_registration_url @user
        expect(response.body).to include @user.email
      end
    end

    context '認証していないユーザーとして' do
      it 'リクエストが失敗すること' do
        get edit_user_registration_url @user
        expect(response).to have_http_status '401'
      end

      it 'サインイン画面にリダイレクトされること' do
        get edit_user_registration_url @user
        expect(response.body).to include 'アカウント登録もしくはログインしてください。'
      end
    end
  end

  describe 'DELETE #destroy' do
    pending '認証済みのユーザーとして' do
      it 'ユーザーが削除されること' do
        sign_in @user
        expect {
          delete user_registration_url @user
        }.to change(User, :count).by(-1)
      end
    end

    context '認証していないユーザーとして' do
      it 'ユーザーは削除されず､ユーザー数は変わらないこと' do
        expect {
          delete user_registration_url @user
        }.to change(User, :count).by(0)
      end
    end
  end
end
