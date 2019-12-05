json.dates do
  json.array! @instadates, partial: "search/search", as: :instadate
end

json.users do
  users = []
  @instadates.each do |date|
    users << date.creator
  end
  json.array! users, partial: 'users/user', as: :user
end

json.sent_sparks do
  json.array! @sent_sparks, partial: "sparks/spark", as: :spark
end