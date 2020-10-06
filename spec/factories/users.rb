FactoryBot.define do
  factory :user, aliases: [:traveler]  do
    sequence(:name) { |n| "Test User#{n}"}
    sequence(:email) { |n| "tester#{n}@example.com"}
    sequence(:password) { |n| "testpw#{n}"}
    sequence(:password_confirmation) { |n| "testpw#{n}"}


    # name {"Example User"}
    # email {"user@example.com"}
    # password {"foobar"}
    # password_confirmation {"foobar"}
  end
end
