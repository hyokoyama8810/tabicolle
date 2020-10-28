# 20.times do
#   content = Faker::Address.state + "の" + Faker::Address.city + "に行ってきた!!"
#   Post.create!(content: content, user_id:1)
# end

User.create!(
  email: 'admin@test.com',
  name: '管理者',
  password: 'password',
  password_confirmation: 'password',
  admin: 'true',
  confirmed_at: Time.now
)
