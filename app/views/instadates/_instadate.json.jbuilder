json.extract! instadate,
  :id,
  :activity,
  :city,
  :time,
  :creator_id,
  :partner_id
json.url instadate_url(instadate, format: :json)
