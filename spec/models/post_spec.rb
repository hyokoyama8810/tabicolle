require 'rails_helper'

RSpec.describe Post, type: :model do

  before do
    @user = build(:user)
    @post = build(:post)
  end

  it "ユーザーIDがなければ無効" do
    @post.user_id = nil
    @post.valid?
    expect(@post.errors[:user_id]).to include("を入力してください")
  end

  it "投稿のuser_idとユーザーのidが一致していれば有効" do

  end

  it "本文がなければ無効" do
    @post.content = nil
    @post.valid?
    expect(@post.errors[:content]).to include("を入力してください")
  end
  it "エリアがなければ無効" do
    @post.area = nil
    @post.valid?
    expect(@post.errors[:area]).to include("を入力してください")
  end
  it "ジャンルがなければ無効" do
    @post.genre = nil
    @post.valid?
    expect(@post.errors[:genre]).to include("を入力してください")
  end
  it "シーズンがなければ無効" do
    @post.season = nil
    @post.valid?
    expect(@post.errors[:season]).to include("を入力してください")
  end

  it "タグがなくても有効" do
    # @post.tag_list = nil
    # expect(@post).to be_valid
  end

  it "はid降順に並ぶ" do
    # testpost1=create(:post)
    # testpost2=create(:post)
    # testpost3=create(:post)
    # expect(Post.first).to eq testpost3
  end

end
