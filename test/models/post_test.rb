require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:alice)
    # このコードは慣習的に正しくない
    @post = @user.posts.build(content: "静岡県に行ってきた!")
  end

  test "should be valid" do
    assert @post.valid?
  end


  # バリデーション
  ## user_id
  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  ## content
  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  #====================================================

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end

  test "associated posts should be destroyed" do
    @user.save
    # @user.posts.create!(content: "静岡に行ってきた!!")
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end

end
