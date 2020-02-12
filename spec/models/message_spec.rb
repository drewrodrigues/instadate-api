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

require 'rails_helper'

RSpec.describe Message, type: :model do
  subject do
    user = build_stubbed(:user)
    conversation = build_stubbed(:conversation, accepting_user: user)
    message = build(:message, conversation: conversation, user: user)
    message.stub(:conversation_at_limit?) { false }
    message
  end

  describe 'validations' do
    it { should belong_to(:conversation) }
    it { should belong_to(:user) }
    it { should validate_presence_of(:body) }
  end

  describe 'limits' do
    context 'when 0 messages in conversation' do
      it 'is valid' do
        # TODO: abstract out with factory
        user = build_stubbed(:user)
        conversation = build_stubbed(:conversation, accepting_user: user)
        message = build(:message, conversation: conversation, user: user)

        expect(message).to be_valid
      end
    end

    context 'when 10 messages in conversation' do
      before(:all) do
        user = build_stubbed(:user)
        conversation = build_stubbed(:conversation, accepting_user: user)
        @message11 = build(:message, conversation: conversation, user: user)
      end

      it 'is invalid' do
        @message11.stub(:conversation_at_limit?) { true }
        expect(@message11).to be_invalid
      end

      it 'has error' do
        @message11.stub(:conversation_at_limit?) { true }
        @message11.validate
        expect(@message11.errors.full_messages.first).to eq('Conversation at max messages')
      end
    end
  end
end
