# frozen_string_literal: true

require 'faker'
require 'pry'

ActiveRecord::Base.transaction do
  Picture.destroy_all
  Instadate.destroy_all
  User.destroy_all

  locations = [
    {
      city: 'San Francisco, CA',
      latitude: 37.7749,
      longitude: -122.4194
    },
    {
      city: 'Walnut Creek, CA',
      latitude: 37.90142703201782,
      longitude: -122.05736366540268
    },
    {
      city: 'Santa Rosa, CA',
      latitude: 38.440430,
      longitude: -122.714058
    },
    {
      city: 'Rohnert Park, CA',
      latitude: 38.346069,
      longitude: -122.709892
    },
    {
      city: 'Mexico City, Mexico',
      latitude: 19.432608,
      longitude: -99.133209
    },
    {
      city: '(Near) Mexico City, Mexico',
      latitude: 19.460951,
      longitude: -99.229393
    }
  ]

  (1..40).each do |i|
    sleep(1)
    photo = Picture.new
    photo.file.attach(io: File.open(File.join(Rails.root, "db/seed_data/#{i}.jpeg")), filename: i)
    photo.save

    location_selection = locations[i % locations.length]

    begin
      User.create!(
        email: "#{i}@example.com",
        password: 'password',
        name: i > 20 ? Faker::Name.female_first_name : Faker::Name.male_first_name,
        age: rand(18..100),
        latitude: location_selection[:latitude],
        longitude: location_selection[:longitude],
        sex: i > 20 ? 'woman' : 'man',
        interested_in: i > 20 ? ['man'] : ['woman'],
        outcomes: %w[dating relationship],
        bio: Faker::Hipster.paragraph_by_chars(characters: 200, supplemental: false),
        picture: photo
      )
    rescue StandardError => e
      puts 'failed User with error, trying again:'
      puts e
      retry
    end

    begin
      Instadate.create!(
        creator: User.last,
        latitude: location_selection[:latitude],
        longitude: location_selection[:longitude],
        activity: Instadate::ACTIVITIES.sample
      )
    rescue StandardError => e
      puts 'failed Instadate with error, trying again:'
      puts e
      retry
    end

    puts "user & instadate #{i} created"
  end

  User.last(20).each do |user|
    Spark.create!(
      user_id: user.id,
      instadate_id: User.first.created_instadate.id,
      note: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt u incididunt u incididunt u s.'
    )
  end
end
