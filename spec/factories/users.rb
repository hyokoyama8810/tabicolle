FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Test User#{n}" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    sequence(:password) { |n| "testpw#{n}"}
    sequence(:password_confirmation) { |n| "testpw#{n}"}
  end
end
