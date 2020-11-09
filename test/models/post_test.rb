require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:alice)
    # このコードは慣習的に正しくない
    @post = @user.posts.build(content: "静岡でサッカー見に行ってきた!!",
                              area: "東海",
                              genre: "スポーツ観戦",
                              season: "夏")
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
  # [Why] postのuser_idとuserのidが関連付けられていることを確かめるため｡
  test "user id should match id of @user" do
    assert_equal @post.user_id, @user.id
  end

  ## content
  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  ##area
  test "area should be present" do
    @post.area = "   "
    assert_not @post.valid?
  end

  ##genre
  test "genre should be present" do
    @post.genre = "   "
    assert_not @post.valid?
  end

  ##season
  test "season should be present" do
    @post.season = "   "
    assert_not @post.valid?
  end
  #====================================================

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end





end
