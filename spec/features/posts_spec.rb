# frozen_string_literal: true
# require 'rails_helper'

# RSpec.feature "Posts", type: :feature do

#   scenario "ユーザーが新規投稿をする" do
#     user = FactoryBot.create(:user)

#     visit root_path
#     visit "/users/sign_in"
#     fill_in "メールアドレス", with: user.email
#     fill_in "パスワード", with: user.password
#     click_button "ログイン"
#     expect(page).to have_content "ログインしました。"

#     # expect {
#     #   # visit  new_post_path
#     #   # fill_in "post_content", with: "テスト投稿"
#     #   # select "関東",from: "エリア"
#     #   # select "観光･散策",from: "ジャンル"
#     #   # select "春",from: "シーズン"
#     #   # attach_file('Image', '/path/to/image.jpg')

#     #   click_on "投稿"

#     #   expect(page).to have_content "テスト投稿"
#     #   expect(page).to have_content "#{user.name}"
#     # }.to change(user.posts, :count).by(1)
#   end
# end
