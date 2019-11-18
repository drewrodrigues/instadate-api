ActiveRecord::Base.transaction do
  Instadate.destroy_all
  User.destroy_all

  User.create!(
    email: 'drew@example.com',
    password_digest: '$2a$12$nBoKjl6D3dgjDAtoZ9q7U.Rp64Xv.ZWSpexP5T/rdiNHb1QOSlBKW',
    name: 'Drew',
    age: 24,
    location: 'Walnut Creek, CA',
    sex: 'man',
    interested_in: ['women'],
    outcomes: ['dating', 'relationship'],
    bio: 'Something cool goes here'
  )

  Instadate.create!(
    creator: User.last,
    location: 'San Francisco, CA',
    activity: 'movie'
  )
end