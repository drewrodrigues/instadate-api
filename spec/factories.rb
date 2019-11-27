FactoryBot.define do
  factory :spark do
    instadate
    user
    note { 'Some note goes here' }
  end

  factory :instadate do
    activity { 'drinks' }
    latitude { 37.90142703201782 }
    longitude { -122.05736366540268 }
    time { '2019-11-14 13:03:26' }

    association :creator, factory: :user
  end

  factory :picture do
    file { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'avatar.jpg'), 'image/jpg') }
    verified { false }
  end

  factory :user do
    admin { false }
    sequence(:email) { |i| "drew#{i}@example.com" }
    name { 'Drew' }
    password_digest { '$2a$12$DzPxx3jLfbUGZcNSJENj4eDviNIEIgM8bKaPYAlLgRiPsaUVdYK6.' } # 'password'
    session_token { 'zJ94Hk5VqRpL9PH4xaqo5w==' }
    age { 24 }
    location { 'San Francisco, CA' }
    sex { 'man' }
    interested_in { ['woman'] }
    outcomes { ['dating'] }
    bio { 'Cool bio goes here' }
  end
end
