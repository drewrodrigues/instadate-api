class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true
  validate :not_at_conversation_limit, on: :create

  private

  def not_at_conversation_limit
    errors.add(:conversation, 'at max messages') if conversation.messages.count >= 10
  end
end
