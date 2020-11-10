# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include Warden::Test::Helpers
  def setup
    Warden.test_mode!
    @user = User.new(name: 'Example User',
                     email: 'user@example.com',
                     password: 'foobar',
                     password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  # バリデーションテスト======================================
  ## name
  test 'name should be present' do
    @user.name = '   '
    assert_not @user.valid?
  end

  ## email
  test 'email should be present' do
    @user.email = '    '
    assert_not @user.valid?
  end
  test 'email validation should accept valid addresses' do
    valid_addresses = %w[hogehoge@example.com
                         test123@test.com
                         FooBar@invalid.net
                         123-456-789@example.co.jp]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  ## password
  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end
  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'pw123'
    assert_not @user.valid?
  end
  #=========================================================

  test 'associated posts should be destroyed' do
    @user.save
    @user.posts.create!(content: '静岡でサッカー見に行ってきた!!',
                        area: '東海',
                        genre: 'スポーツ観戦',
                        season: '夏')
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end

  # [todo]RED フォローされない
  # test "should follow and unfollow a user" do
  #   alice = users(:alice)
  #   bob  = users(:bob)
  #   assert_not alice.following?(bob)
  #   alice.follow(bob)
  #   assert alice.following?(bob)
  #   assert bob.followers.include?(alice)
  #   alice.unfollow(bob)
  #   assert_not alice.following?(bob)
  # end
end
