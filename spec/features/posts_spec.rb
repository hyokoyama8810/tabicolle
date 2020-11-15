# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', js: true, type: :feature do
  it 'ユーザーが新規投稿して､編集､削除をする' do
    user = create(:user)

    visit root_path
    click_on 'ログイン', match: :first
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'

    expect {
      click_on '新規投稿', match: :first
      fill_in '投稿内容', with: '東京スカイツリーに行ってきた!!'
      select '関東', from: 'エリア'
      select '観光･散策', from: 'ジャンル'
      select '春', from: 'シーズン'
      fill_in 'タグ', with: '東京スカイツリー, 東京'
      attach_file('写真', 'spec/features/images/testimg.png')

      click_on '投稿'

      expect(page).to have_content user.name.to_s
      expect(page).to have_content '東京スカイツリーに行ってきた!!'
      expect(page).to have_content '関東'
      expect(page).to have_content '観光･散策'
      expect(page).to have_content '春'
      expect(page).to have_content '東京スカイツリー'
      expect(page).to have_content '東京'
      # [todo] 画像が出力されているかテストしたい
    }.to change(user.posts, :count).by(1)
    expect(page).to have_current_path "/users/#{user.id}"
    expect(page).to have_content '投稿が作成されました｡'

    # edit
    click_on '編集', match: :first
    fill_in '投稿内容', with: '東京タワーに行ってきた!!'
    select '夏', from: 'シーズン'
    fill_in 'タグ', with: '東京タワー, 東京'

    click_on '更新'

    expect(page).to have_content user.name.to_s
    expect(page).to have_content '東京タワーに行ってきた!!'
    expect(page).to have_content '関東'
    expect(page).to have_content '観光･散策'
    expect(page).to have_content '夏'
    expect(page).to have_content '東京タワー'
    expect(page).to have_content '東京'

    expect(page).to have_current_path "/users/#{user.id}"
    expect(page).to have_content '投稿が編集されました'

    # delete
    click_on '削除'
    expect {
      expect(page.accept_confirm).to eq '投稿を削除してもよろしいですか?'
      expect(page).to have_content '投稿を削除しました'
    }.to change(user.posts, :count).by(-1)
    expect(page).to have_current_path "/users/#{user.id}"
  end
end
