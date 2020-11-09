require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @post = posts(:Kanazawa)
    @user = users(:alice)
    @other_user = users(:bob)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "金沢城に行ってきたよ!!" } }
    end
    assert_redirected_to new_user_session_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to new_user_session_url
  end

  test "should redirect destroy for wrong post" do
    login_as(users(:alice), scope: :user)
    post = posts(:Nagano)
    assert_no_difference 'Post.count' do
      delete post_path(post)
    end
    assert_redirected_to new_user_session_url # [todo] root_pathにリダイレクトするようにしたい
  end
end
