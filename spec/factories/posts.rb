FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "testpost#{n}"}
    area {"東海"}
    genre {"スポーツ観戦"}
    season {"夏"}
    # tag_list {["foo","bar"]}
    # sequence(:user_id) {|n| "#{n}"}

    # association :traveler

  end
end
