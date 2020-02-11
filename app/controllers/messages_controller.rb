class MessagesController < ApplicationController
  # POST /messages
  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      render @message
    else
      render @message.errors
    end
  end

  private

  def message_params
    params.require(:message).permit(:conversation_id, :body)
  end
end
