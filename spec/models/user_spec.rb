# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  admin           :boolean          default("false")
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :text             not null
#  age             :integer          not null
#  location        :string           not null
#  sex             :string           not null
#  interested_in   :string           default("{}"), not null, is an Array
#  outcomes        :string           default("{}"), not null, is an Array
#  name            :string           not null
#  bio             :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

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
    it { should validate_presence_of(:sex) }
    it { should validate_presence_of(:name) }

    # inclusion
    it { should validate_inclusion_of(:age).in_range(18..100) }
    it { should validate_inclusion_of(:sex).in_array(%w[man woman]) }

    # uniqueness
    it { should validate_uniqueness_of(:email).case_insensitive }

    describe 'outcomes' do
      it 'requires at least one selection' do
        user = build(:user, outcomes: [])
        expect(user).to_not be_valid
      end

      it 'allows all combinations of dating, hookups, and relationships' do
        options = %w[dating hookups relationship]

        subsets = []
        options.each do |left|
          current_subset = [left]

          subsets.dup.each do |subset|
            subsets << subset + current_subset
          end

          subsets << current_subset
        end

        subsets.each do |option_subset|
          expect(build(:user, outcomes: option_subset)).to be_valid
        end
      end

      it 'is invalid with other other outcomes' do
        user = build(:user, outcomes: %w[dating hookups relationship other])
        expect(user).to be_invalid
      end
    end

    describe 'interested in' do
      it 'requires at least one selection' do
        user = build(:user, interested_in: [])
        expect(user).to_not be_valid
      end

      it 'allows all combinations of dating, hookups, and relationships' do
        subsets = []

        User::INTERESTED_IN_OPTIONS.each do |left|
          current_subset = [left]

          subsets.dup.each do |subset|
            subsets << subset + current_subset
          end

          subsets << current_subset
        end

        subsets.each do |option_subset|
          expect(build(:user, interested_in: option_subset)).to be_valid
        end
      end

      it 'is invalid with other other outcomes' do
        user = build(:user, interested_in: User::INTERESTED_IN_OPTIONS + ['other'])
        expect(user).to be_invalid
      end
    end
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
