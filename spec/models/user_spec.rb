# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
  end

  it '有効なファクトリを持つこと' do
    expect(@user).to be_valid
  end

  it '名前がなければ無効' do
    @user.name = nil
    @user.valid?
    expect(@user.errors[:name]).to include('を入力してください')
  end

  it 'メールアドレスがなければ無効' do
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to include('を入力してください')
  end

  it '不正な値のアドレスは無効' do
    invalid_emails = %w[@@@gmail.com hogehogegmail.com hogegmail@]
    invalid_emails.each do |email|
      @user.email = email
      @user.valid?
      expect(@user.errors[:email]).to include('は不正な値です')
    end
  end

  it '重複したメールアドレスなら無効' do
    create(:user, email: 'same-address@example.com') # ①
    @user.email = 'same-address@example.com' # ②
    @user.valid?
    expect(@user.errors[:email]).to include('はすでに存在します')
    # createはbuildと違い保存(永続化)されるため､①のユーザーが保存され､②は無効になる｡
  end

  it 'パスワードがなければ無効' do
    @user.password = nil
    @user.valid?
    expect(@user.errors[:password]).to include('を入力してください')
  end

  it 'パスワードが6文字未満だと無効' do
    @user.password = 'pw123'
    @user.valid?
    expect(@user.errors[:password]).to include('は6文字以上で入力してください')
  end

  it '確認用パスワードとパスワードの入力が一致しないと無効' do
    @user.password_confirmation = 'invalidpw'
    @user.valid?
    expect(@user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
  end
end
