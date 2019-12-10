json.conversations do
  json.array! @conversations, partial: "conversations/conversation", as: :conversation
end

json.message({})
json.user({})
