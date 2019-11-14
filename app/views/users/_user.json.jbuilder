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
    json.url url_for(user.picture.file)
    json.verified user.picture.verified
  else
    json.nil!
  end
end