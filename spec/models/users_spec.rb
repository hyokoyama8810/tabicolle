require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe 'バリデーション' do
    it 'usernameとemail,passwordの値が設定されていれば、OK' do
      expect(@user.valid?).to eq(true)
    end

    it 'usernameが空だとNG' do
      @user.username = ''
      expect(@user.valid?).to eq(false)
    end

    it 'emailが空だとNG' do
      @user.email = ''
      expect(@user.valid?).to eq(false)
    end

    describe 'パスワードが空あるいは5文字以内だとNG' do
      it 'パスワードが空だとNG' do
        @user.password = ''
        @user.password_confirmation = ''
        expect(@user.valid?).to eq(false)
      end
      it 'パスワードが5文字以内だとNG' do
        @user.password = 'mukou'
        @user.password_confirmation = 'mukou'
        expect(@user.valid?).to eq(false)
      end
    end

  end
end
