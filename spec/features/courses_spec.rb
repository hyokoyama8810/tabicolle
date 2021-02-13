# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Courses', type: :feature do
  it 'ユーザーが新規投稿して､編集､削除をする', js: true do
    user = create(:user)

    visit root_path
    click_on 'ログイン', match: :first
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    # create
    expect {
      click_on '新規モデルコース投稿'
      fill_in 'タイトル', with: '金沢･富山･福井 北陸観光モデルコース'
      fill_in '日付', with: '2021/01/01'
      fill_in 'メモ', with: '冬の北陸はかなり寒いので､温かい格好と滑りにくい靴を準備することをおすすめします｡'

      click_on '投稿'

      expect(page).to have_content user.name.to_s
      expect(page).to have_content '金沢･富山･福井 北陸観光モデルコース / 1月'
    }.to change(user.courses, :count).by(1)
    expect(page).to have_current_path '/courses'
    expect(page).to have_content 'モデルコースが作成されました｡'

     # show
    click_on '金沢･富山･福井 北陸観光モデルコース / 1月'
    expect(page).to have_current_path '/courses/1'
    expect(page).to have_content '金沢･富山･福井 北陸観光モデルコース / 1月'
    expect(page).to have_content '冬の北陸はかなり寒いので､温かい格好と滑りにくい靴を準備することをおすすめします｡'

    # edit
    click_on '編集'
    expect(page).to have_current_path '/courses/1/edit'
    fill_in 'タイトル', with: '金沢･富山･福井 北陸観光･散策モデルコース'
    fill_in '日付', with: '2021/02/01'
    fill_in 'メモ', with: '冬の北陸はかなり寒いので､暖かい格好と滑りにくい靴を準備することをおすすめします｡'
    click_on '更新'

    expect(page).to have_current_path '/courses/1'
    expect(page).to have_content '冬の北陸はかなり寒いので､暖かい格好と滑りにくい靴を準備することをおすすめします｡'
    expect(page).to have_content 'モデルコースが編集されました'

    # delete
    click_on '削除'
    expect {
      expect(page.accept_confirm).to eq 'モデルコースを削除してもよろしいですか?'
      expect(page).to have_content 'モデルコースを削除しました'
    }.to change(user.courses, :count).by(-1)
    expect(page).to have_current_path '/courses'
  end
end
