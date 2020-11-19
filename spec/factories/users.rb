# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Test User#{n}" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    sequence(:password) { |n| "testpw#{n}" }
    sequence(:password_confirmation) { |n| "testpw#{n}" }
    before(:create) { |user|
      # ここで認証済みでメールを送信しない設定を行う
      user.skip_confirmation_notification!
      user.skip_confirmation!
    }
  end
end
