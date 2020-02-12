# frozen_string_literal: true

json.partial! 'instadates/instadate', instadate: instadate
json.distance instadate.distance_to([@latitude, @longitude]).to_i
