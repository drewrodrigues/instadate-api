json.conversation do
  json.partial! "conversations/conversation", conversation: @conversation
end

json.messages([])