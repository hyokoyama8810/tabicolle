User.create!(
  email: 'admin@test.com',
  name: '管理者',
  password: 'password',
  password_confirmation: 'password',
  admin: 'true',
  confirmed_at: Time.now
)
User.create!(
  email: ENV['GMAIL_ADDRESS'],
  name: 'SAMPLE USER',
  password: 'password',
  password_confirmation: 'password',
  admin: 'true',
  confirmed_at: Time.now
)


10.times do |n|
  User.create!(
    name:  Faker::Name.name,
    email: "test-#{n+1}@example.com",
    password: "password",
    password_confirmation: "password",
    confirmed_at: Time.now
  )
end

users = User.order(:created_at).take(6)

areas = ['北海道･東北', '関東', '北陸･甲信越', '東海', '関西', '中国･四国', '九州･沖縄', '海外･その他']
genres = ['観光･散策', 'グルメ', '体験･アクティビティ', '温泉', 'スポーツ観戦', 'その他']
seasons = %w[春 夏 秋 冬]

5.times do
  users.each do |user|
    user.posts.create!(
      content: Faker::Address.state + "の" + Faker::Address.city + "に行ってきた!!",
      area: areas.sample,
      genre: genres.sample,
      season: seasons.sample
    )
  end
end

