FactoryBot.define do
  factory :user do
    admin { false }
    email { 'drew@example.com' }
    name { 'Drew' }
    password_digest { '$2a$12$DzPxx3jLfbUGZcNSJENj4eDviNIEIgM8bKaPYAlLgRiPsaUVdYK6.' } # 'password'
    session_token { 'zJ94Hk5VqRpL9PH4xaqo5w==' }
    age { 24 }
    location { 'San Francisco, CA' }
    sex { 'male' }
    interested_in { 'women' }
    outcome { 'dating' }
    bio { 'Cool bio goes here' }
  end
end