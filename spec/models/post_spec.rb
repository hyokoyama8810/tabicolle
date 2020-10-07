require 'rails_helper'

RSpec.describe Post, type: :model do

  before do
    @user = create(:user)
    @post = create(:post)
  end

  it "ユーザーIDがないとき無効になる" do
    @post.user_id = nil
    @post.valid?
    expect(@post.errors[:user_id]).to include("を入力してください")
  end

  pending "投稿のuser_idとユーザーのidが一致している" do
    expect(@post.user_id).to eq @user.id
  end

  it "本文がないとき無効になる" do
    @post.content = nil
    @post.valid?
    expect(@post.errors[:content]).to include("を入力してください")
  end
  it "エリアがないとき無効になる" do
    @post.area = nil
    @post.valid?
    expect(@post.errors[:area]).to include("を入力してください")
  end
  it "ジャンルがないとき無効になる" do
    @post.genre = nil
    @post.valid?
    expect(@post.errors[:genre]).to include("を入力してください")
  end
  it "シーズンがないとき無効になる" do
    @post.season = nil
    @post.valid?
    expect(@post.errors[:season]).to include("を入力してください")
  end

  it "タグがなくても有効になる" do
    @post.tag_list = nil
    expect(@post).to be_valid
  end

  it "投稿日時が新しい順に並ぶ" do
    testpost1=create(:post)
    testpost2=create(:post)
    testpost3=create(:post)
    expect(Post.first).to eq testpost3
  end

end
