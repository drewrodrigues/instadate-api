# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[show destroy]

  # GET /conversations
  def index
    @conversations = current_user.conversations.all
  end

  # GET /conversations/1
  def show
    @conversation = current_user.conversations.find(params[:id])
  end

  # POST /conversations
  def create
    spark = current_user.received_sparks.find(params[:conversation][:spark_id])
    spark.transaction do
      spark.destroy!
      @conversation = Conversation.new(
        requesting_user_id: spark.user_id,
        accepting_user_id: current_user.id
      )

      if @conversation.save!
        render json: @conversation
      else
        render json: @conversation.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /conversations/1
  def destroy
    @conversation.destroy
    render json: @conversation
  end

  private

  def set_conversation
    @conversation = current_user.conversations.find(params[:id])
  end
end
