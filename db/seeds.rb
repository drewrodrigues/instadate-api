ActiveRecord::Base.transaction do
  Picture.destroy_all
  Instadate.destroy_all
  User.destroy_all

  20.times do |i|
    photo = Picture.new
    photo.file.attach(io: File.open(File.join(Rails.root, "db/seed_data/#{i+1}.jpeg")), filename: i)
    photo.save

    User.create!(
      email: "drew#{i}@example.com",
      password_digest: '$2a$12$nBoKjl6D3dgjDAtoZ9q7U.Rp64Xv.ZWSpexP5T/rdiNHb1QOSlBKW',
      name: "Drew #{i}",
      age: 24,
      location: 'Walnut Creek, CA',
      sex: 'man',
      interested_in: ['women'],
      outcomes: ['dating', 'relationship'],
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