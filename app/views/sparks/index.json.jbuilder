# frozen_string_literal: true

json.sparks do
  json.array! @sparks, partial: 'sparks/spark', as: :spark
end

json.users do
  users = []
  @sparks.each do |spark|
    users << spark.user
  end
  json.array! users, partial: 'users/user', as: :user
end
