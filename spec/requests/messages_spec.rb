require 'rails_helper'

RSpec.describe 'Message requests', type: :request do
  before do
    user = build_stubbed(:user)
    ApplicationController.any_instance.stub(:current_user) { user }
    message = build(:message, user_id: 200, conversation_id: 250, body: 'Message')
    allow_any_instance_of(User).to receive_message_chain('messages.build') { message }
  end

  describe 'POST /messages' do
    it 'has correct response' do
      Message.any_instance.stub(:save) { true }

      headers = { 'Accept' => 'application/json' }
      post '/messages',
           params: { message: attributes_for(:message) },
           headers: headers

      expect(JSON.parse(response.body)).to eq(
        'message' => {
          'body' => 'Message',
          'conversation_id' => 250,
          'user_id' => 200
        }
      )
    end

    context 'on fail' do
      it 'has errors' do
        Message.any_instance.stub(:save) { false }
        Message.any_instance.stub(:errors) { ['some errors'] }

        headers = { 'Accept' => 'application/json' }
        post '/messages',
             params: { message: attributes_for(:message) },
             headers: headers
        expect(JSON.parse(response.body)).to eq('errors' => ['some errors'])
      end
    end
  end
end