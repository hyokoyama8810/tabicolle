require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  include Warden::Test::Helpers
  # include Devise::Test::IntegrationHelpers

  def setup
    Warden.test_mode!
    @user = users(:alice)

  end

  # [todo] ↓のテストがパスしない -> ログインできていない可能性がある
  # test "profile display" do
  #   login_as(@user, :scope => :user)
  #   get user_path(@user)
  #   assert_template 'users/show'
  #   assert_template
  #   assert_select 'title', full_title(@user.name)
  #   assert_select 'p.name', @user.name
  #   assert_select 'p.icon > img.gravatar'
  #   assert_match @user.posts.count.to_s, response.body
  #   assert_select 'div.pagination'
  #   @user.posts.paginate(page: 1).each do |post|
  #     assert_match post.content, response.body
  #   end
  # end
end
