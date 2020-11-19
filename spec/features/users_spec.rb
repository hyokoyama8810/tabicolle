# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  it '新規登録フォームを入力しメール認証をして､サインアップ･ログインを完了させる' do
    visit root_path
    click_on '新規登録', match: :first
    fill_in 'ユーザー名', with: 'Alice'
    fill_in 'メールアドレス', with: 'alice@example.com'
    fill_in 'パスワード', with: 'alice123'
    fill_in 'パスワード確認', with: 'alice123'
    expect {
      click_on 'アカウント作成'
    }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'

    user = User.last
    token = user.confirmation_token
    visit user_confirmation_path(confirmation_token: token)
    expect(page).to have_content 'アカウントを登録しました。'

    fill_in 'メールアドレス', with: 'invalid@example.com'
    fill_in 'パスワード', with: 'alice123'
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレス もしくはパスワードが間違っています。'

    fill_in 'メールアドレス', with: 'alice@example.com'
    fill_in 'パスワード', with: 'invalid123'
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレス もしくはパスワードが間違っています。'

    fill_in 'メールアドレス', with: 'alice@example.com'
    fill_in 'パスワード', with: 'alice123'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
  end

  it 'プロフィールを変更する' do
    user = create(:user)

    visit root_path
    click_on 'ログイン', match: :first
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'

    click_on 'プロフィール変更'
    fill_in 'ユーザー名', with: 'Bob'
    fill_in '現在のパスワード', with: user.password
    click_on '更新'
    expect(page).to have_content 'アカウント情報を変更しました。'

    click_on 'マイページ'
    expect(page).to have_content 'Bob'

    click_on 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
    expect(page).to have_content 'ログイン'
  end
end
