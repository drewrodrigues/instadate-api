require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'validations' do
    # presence
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:bio) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:outcome) }
    it { should validate_presence_of(:interested_in) }
    it { should validate_presence_of(:sex) }
    it { should validate_presence_of(:name) }

    # inclusion
    it { should validate_inclusion_of(:age).in_range(18..100) }
    it { should validate_inclusion_of(:interested_in).in_array(%w[men women both]) }
    it { should validate_inclusion_of(:sex).in_array(%w[male female]) }

    # uniqueness
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'session_tokens' do
    it 'assigns a session token on initialization' do
      user = User.new
      expect(user.session_token).to_not be_nil
    end
  end

  describe '#authenticate_password' do
    context 'with correct password' do
      it 'resets the session_token' do
        user = build(:user)
        expect {
          user.authenticate_password('password')
        }.to change(user, :session_token)
      end

      it 'returns the user' do
        user = build(:user)
        expect(user.authenticate_password('password')).to eq(user)
      end
    end

    context 'with incorrect password' do
      it 'returns nil' do
        expect(user.authenticate_password('incorrect_password'))
      end
    end
  end
end
