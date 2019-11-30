json.extract! instadate,
  :id,
  :activity,
  :latitude,
  :longitude,
  :time,
  :creator_id,
  :partner_id,
  :created_at,
  :updated_at
json.url instadate_url(instadate, format: :json)
