# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe '#home' do
    it '正常にレスポンスを返すこと' do
      get :home
      expect(response).to be_successful
    end
  end
end
