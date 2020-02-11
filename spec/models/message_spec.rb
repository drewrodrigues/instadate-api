require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    it { should belong_to(:conversation) }
    it { should belong_to(:user) }
    it { should validate_presence_of(:body) }
  end

  describe 'limits' do
    context 'when 0 messages in conversation' do
      it 'is valid' do
        user = create(:user)
        conversation = create(:conversation, accepting_user: user)
        message = build(:message, conversation: conversation, user: user)

        expect(message).to be_valid
      end
    end

    context 'when 10 messages in conversation' do
      before(:all) do
        user = create(:user)
        conversation = create(:conversation, accepting_user: user)

        10.times do
          create(:message, conversation: conversation, user: user)
        end

        @message_11 = build(:message, conversation: conversation, user: user)
      end

      it 'is invalid' do
        expect(@message_11).to be_invalid
      end

      it 'has error' do
        @message_11.validate
        expect(@message_11.errors.full_messages.first).to eq('Conversation at max messages')
      end
    end
  end
end
