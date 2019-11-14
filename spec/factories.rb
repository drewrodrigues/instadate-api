FactoryBot.define do
  factory :picture do
    file { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'avatar.jpg'), 'image/jpg') }
    verified { false }
  end

  factory :user do
    admin { false }
    email { 'drew@example.com' }
    name { 'Drew' }
    password_digest { '$2a$12$DzPxx3jLfbUGZcNSJENj4eDviNIEIgM8bKaPYAlLgRiPsaUVdYK6.' } # 'password'
    session_token { 'zJ94Hk5VqRpL9PH4xaqo5w==' }
    age { 24 }
    location { 'San Francisco, CA' }
    sex { 'man' }
    interested_in { ['women'] }
    outcomes { ['dating'] }
    bio { 'Cool bio goes here' }
  end
end