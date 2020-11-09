require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  # include Devise::TestHelpers
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:alice)
    @other_user = users(:bob)
  end

  # ログインユーザーでない場合
  test "should redirect show when not logged in" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
  end
  ## [todo] deviseのヘルパーメソッド authenticate_user! は通過できない場合､ログでは 401 を返しており､遍移先のurlは返さない?? → ログイン画面に遍移したかまでテストできない
  test "should redirect edit when not logged in" do
    get edit_user_registration_path(@user)
    assert_response 401
    # assert_not flash.empty?
    # assert_redirected_to new_user_session_url
  end
  test "should redirect update when not logged in" do
    patch  user_registration_path(@user), params: { user: { name: @user.name,
                                                            email: @user.email } }
    assert_response 401
    # assert_not flash.empty?
    # assert_redirected_to new_user_session_url
  end
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_registration_path(@user)
    end
    assert_response 401
    # assert_redirected_to new_user_session_url
  end

  # 異なるユーザーとしてログインした場合
  test "should redirect edit when logged in as wrong user" do
    # login_as(@other_user, scope: :user)
    login_as(@other_user)
    get edit_user_registration_path(@user)
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
  end
  test "should redirect update when logged in as wrong user" do
    login_as(@other_user, scope: :user)
    patch user_registration_path(@user), params: { user: { name: @user.name,
                                                           email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
  end
  test "should redirect destroy when logged in as wrong user" do
    login_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_registration_path(@user)
    end
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
  end

  # 正しいユーザーとしてログインした場合
  test "should redirect update when logged in as correct user" do
    login_as(@user, scope: :user)
    patch user_registration_path(@user), params: { user: { name: "new",
                                                           email: "new@example.com" } }
    assert_not flash.empty?
  end
  # [todo] ↓のテストがパスしない､ User.countが -1 にならない
  # test "should redirect destroy when logged in as correct user" do
  #   login_as(@user, scope: :user)
  #   assert_difference 'User.count', -1 do
  #     delete user_registration_path(@user)
  #   end
  #   assert_not flash.empty?
  # end
end
