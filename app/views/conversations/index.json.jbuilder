json.conversations do
  json.array! @conversations, partial: "conversations/conversation", as: :conversation
end

json.users do
  users = []
  @conversations.each do |conversation|
    other_user = if current_user.id == conversation.accepting_user_id
                   conversation.requesting_user
                 else
                   conversation.accepting_user
                 end
    users << other_user
  end
  json.array! users, partial: 'users/user', as: :user
end
