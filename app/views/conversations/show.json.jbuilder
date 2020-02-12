# frozen_string_literal: true

json.conversation do
  json.partial! 'conversations/conversation', conversation: @conversation
end

json.messages([])
