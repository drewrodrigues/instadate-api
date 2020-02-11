FactoryBot.define do
  factory :message do
    body { "MyText" }
    conversation
    user
  end

  factory :conversation do
    association :accepting_user, factory: :user
    association :requesting_user, factory: :user
  end

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
    latitude { 37.783675599999995 }
    longitude { -122.41273609999999 }
    city { 'San Francisco' }
    sex { 'man' }
    interested_in { ['woman'] }
    outcomes { ['dating'] }
    bio { 'Cool bio goes here' }
  end
end
