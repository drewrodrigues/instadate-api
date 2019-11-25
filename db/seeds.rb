ActiveRecord::Base.transaction do
  Picture.destroy_all
  Instadate.destroy_all
  User.destroy_all

  (1..40).each do |i|
    photo = Picture.new
    photo.file.attach(io: File.open(File.join(Rails.root, "db/seed_data/#{i}.jpeg")), filename: i)
    photo.save

    User.create!(
      email: "drew#{i}@example.com",
      password_digest: '$2a$12$nBoKjl6D3dgjDAtoZ9q7U.Rp64Xv.ZWSpexP5',
      name: i > 20 ? "Girl Name #{i}" : "Guy Name #{i}",
      age: 24,
      location: 'Walnut Creek, CA',
      sex: i > 20 ? 'woman' : 'man',
      interested_in: i > 20 ? ['man'] : ['woman'],
      outcomes: %w[dating relationship],
      bio: 'Something cool goes here',
      picture: photo
    )

    Instadate.create!(
      creator: User.last,
      location: 'San Francisco, CA',
      activity: Instadate::ACTIVITIES.sample
    )
  end
end
