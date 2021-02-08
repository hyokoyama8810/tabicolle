# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  before do
    @user = create(:user)
    @course = create(:course)
  end

  it 'タイトルがないとき無効になる' do
    @course.title = nil
    @course.valid?
    expect(@course.errors[:title]).to include('を入力してください')
  end

  it '全体メモがなくても有効になる' do
    @course.general_memo = nil
    expect(@course).to be_valid
  end

  it '日時がないとき無効になる' do
    @course.date = nil
    @course.valid?
    expect(@course.errors[:date]).to include('を入力してください')
  end
end
