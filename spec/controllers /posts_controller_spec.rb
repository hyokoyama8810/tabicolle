# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe '#index' do
    before do
      @user = create(:user)
    end

    it '正常にレスポンスを返すこと' do
      sign_in @user
      get :index
      expect(response).to be_successful
    end

    # it '200レスポンスを返すこと' do
    #   sign_in @user
    #   get :index
    #   expect(response).to have_http_status '200'
    # end
  end
end
