# frozen_string_literal: false

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe '#home' do
    it '正常なレスポンスを返すこと' do
      get :home
      expect(response).to have_http_status '200'
    end
  end
end
