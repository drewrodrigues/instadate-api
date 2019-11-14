json.extract! user,
              :id,
              :admin,
              :email,
              :session_token,
              :age,
              :location,
              :sex,
              :interested_in,
              :outcomes,
              :name,
              :bio

json.picture do
  if user.picture
    json.url polymorphic_url(user.picture.file)
    json.verified user.picture.verified
  else
    json.nil!
  end
end