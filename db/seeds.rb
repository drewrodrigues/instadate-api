require 'faker'

ActiveRecord::Base.transaction do
  Picture.destroy_all
  Instadate.destroy_all
  User.destroy_all

  SF_LATITUDE = 37.7749
  SF_LONGITUDE = -122.4194
  WALNUT_CREEK_LATITUDE = 37.90142703201782
  WALNUT_CREEK_LONGITUDE = -122.05736366540268

  (1..40).each do |i|
    photo = Picture.new
    photo.file.attach(io: File.open(File.join(Rails.root, "db/seed_data/#{i}.jpeg")), filename: i)
    photo.save

    User.create!(
      email: "#{i}@example.com",
      password: 'password',
      name: i > 20 ? Faker::Name.female_first_name : Faker::Name.male_first_name,
      age: 24,
      location: 'Walnut Creek, CA',
      sex: i > 20 ? 'woman' : 'man',
      interested_in: i > 20 ? ['man'] : ['woman'],
      outcomes: %w[dating relationship],
      bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullam ullam ullam sed do.',
      picture: photo
    )

    Instadate.create!(
      creator: User.last,
      latitude: i.even? ? SF_LATITUDE : WALNUT_CREEK_LATITUDE,
      longitude: i.even? ? SF_LONGITUDE : WALNUT_CREEK_LONGITUDE,
      activity: Instadate::ACTIVITIES.sample
    )
  end

  User.last(4).each do |user|
    Spark.create!(
      user_id: user.id,
      instadate_id: User.first.created_instadate.id,
      note: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt u incididunt u incididunt u s.'
    )
  end
end
