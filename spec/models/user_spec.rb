require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = User.create(
      name: "Example User",
      email: "user@example.com",
      password: "foobar",
      password_confirmation:"foobar"
    )
  end

  it "名前、メール、パスワードがあれば有効" do
    user = User.new(
      name: "Example User",
      email:      "tester@example.com",
      password:   "foobar",
      password_confirmation:"foobar"

    )
    expect(user).to be_valid
  end

  it "名前がなければ無効" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスがなければ無効" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "不正な値のアドレスは無効" do
    invalid_emails=%w(@@@gmail.com hogehogegmail.com hogegmail@)
    invalid_emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
  end

  it "重複したメールアドレスなら無効" do
    User.create(
      name:  "Example User",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
    )
    user = User.new(
      name:  "Jane Tester",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "パスワードがなければ無効" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "パスワードが6文字未満だと無効" do
    user = User.new(password: "pw123")
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end

  it "確認用パスワードとパスワードの入力が一致しないと無効" do
    user = User.new(password:"password", password_confirmation: "")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end

end
