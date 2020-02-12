# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  body            :text             not null
#  conversation_id :integer          not null
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#

class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true
  validate :not_at_conversation_limit, on: :create

  def conversation_at_limit?
    total_conversation_messages >= 10
  end

  def total_conversation_messages
    @total_conversation_messages ||= conversation.messages.count
  end

  private

  def not_at_conversation_limit
    errors.add(:conversation, 'at max messages') if conversation_at_limit?
  end
end
