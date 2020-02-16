# frozen_string_literal: true

class MessagesController < ApplicationController
  # POST /messages
  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      render :show
    else
      render json: { 'errors' => @message.errors }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:conversation_id, :body)
  end
end
