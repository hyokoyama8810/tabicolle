# frozen_string_literal: true

FactoryBot.define do
  areas = ['北海道･東北', '関東', '北陸･甲信越', '東海', '関西', '中国･四国', '九州･沖縄', '海外･その他']
  genres = ['観光･散策', 'グルメ', '体験･アクティビティ', '温泉', 'スポーツ観戦', 'その他']
  seasons = %w[春 夏 秋 冬]

  factory :post do
    sequence(:content) { |n| "testpost#{n}" }
    area { areas.sample }
    genre { genres.sample }
    season { seasons.sample }
    association :user
  end
end
