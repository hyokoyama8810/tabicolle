# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe '#index' do
    context '認証済みのユーザーとして' do
      before do
        @user = create(:user)
      end

      it '正常にレスポンスを返すこと' do
        sign_in @user
        get :index
        expect(response).to be_successful
      end

      it '200レスポンスを返すこと' do
        sign_in @user
        get :index
        expect(response).to have_http_status '200'
      end
    end

    context '認証していないユーザーとして' do
      it '302レスポンスを返すこと' do
        get :index
        expect(response).to have_http_status '302'
      end

      it 'サインイン画面にリダイレクトされること' do
        get :index
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
