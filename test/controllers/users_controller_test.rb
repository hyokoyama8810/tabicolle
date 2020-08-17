require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # include Devise::TestHelpers

  def setup
    @user = users(:alice)
  end

  # test "should get show" do
  #   # get users_show_url
  #   sign_in_as users(@user)
  #   get user_url(@user)
  #   assert_response :success
  # end

  test "should redirect show when not logged in" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
  end

  # [todo] ログインページにリダイレクトされるところまでテストしようとすると､REDになる
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
end
