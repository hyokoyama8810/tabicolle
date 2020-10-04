require 'rails_helper'

RSpec.describe Post, type: :model do

  it "ユーザーIDがなければ無効" do
    post = Post.new(user_id: nil)
    post.valid?
    expect(post.errors[:user_id]).to include("を入力してください")
  end
end
