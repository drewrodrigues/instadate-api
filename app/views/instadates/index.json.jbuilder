json.dates do
  json.array! @instadates, partial: "instadates/instadate", as: :instadate
end

json.users do
  users = []
  @instadates.each do |date|
    users << date.creator
  end
  json.array! users, partial: 'users/user', as: :user
end
