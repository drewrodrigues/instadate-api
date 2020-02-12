json.message do
  json.extract! @message, :body, :conversation_id, :user_id
end