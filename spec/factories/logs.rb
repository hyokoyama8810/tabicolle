# frozen_string_literal: true

FactoryBot.define do
  factory :log do
    spot { 'MyString' }
    time { '2021-02-27 09:16:51' }
    detailed_memo { 'MyString' }
    course { nil }
  end
end
