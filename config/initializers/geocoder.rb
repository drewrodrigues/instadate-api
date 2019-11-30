Geocoder.configure(
  api_key: ENV['LOCATION_IQ_DEV_API_KEY'],
  lookup: :location_iq,
  # geocoding service request timeout, in seconds (default 3):
  timeout: 5
)