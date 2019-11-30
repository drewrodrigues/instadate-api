ActiveRecord::Base.transaction do
  Picture.destroy_all
  Instadate.destroy_all
  User.destroy_all

  (1..40).each do |i|
    photo = Picture.new
    photo.file.attach(io: File.open(File.join(Rails.root, "db/seed_data/#{i}.jpeg")), filename: i)
    photo.save

    User.create!(
      email: "#{i}@example.com",
      password: 'password',
      name: i > 20 ? "Girl Name #{i}" : "Guy Name #{i}",
      age: 24,
      location: 'Walnut Creek, CA',
      sex: i > 20 ? 'woman' : 'man',
      interested_in: i > 20 ? ['man'] : ['woman'],
      outcomes: %w[dating relationship],
      bio: 'Something cool goes here',
      picture: photo
    )

    if rand(5) == 1
      Instadate.create!(
        creator: User.last,
        latitude: 37.90142703201782,
        longitude: -122.05736366540268,
        activity: Instadate::ACTIVITIES.sample
      )
    end
  end
end
