require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @post = posts(:Kanazawa)
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


end
