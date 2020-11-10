# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "testpost#{n}" }
    area { '東海' }
    genre { 'スポーツ観戦' }
    season { '夏' }
    association :user
  end
end
