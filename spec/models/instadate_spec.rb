# frozen_string_literal: true
# == Schema Information
#
# Table name: instadates
#
#  id         :integer          not null, primary key
#  activity   :string           not null
#  time       :time
#  creator_id :integer          not null
#  partner_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  address    :string           not null
#  city       :string           not null
#  latitude   :float            not null
#  longitude  :float            not null
#

require 'rails_helper'

RSpec.describe Instadate, type: :model do
  subject(:instadate) { build(:instadate) }

  describe 'validations' do
    # associations
    it { should belong_to(:creator) }
    it { should belong_to(:partner).optional }

    # inclusion
    it {
      should validate_inclusion_of(:activity).in_array(Instadate::ACTIVITIES)
    }

    describe 'city validation' do
      it 'allows valid city' do
        instadate = build(:instadate, location: 'San Francisco, CA')
        expect(instadate).to be_valid
      end

      it 'is invalid with invalid city' do
        instadate = build(:instadate, location: 'Invalid Location')
        expect(instadate).to be_invalid
      end
    end

    # custom
    describe '#only_one_created_date' do
      context 'when user has no instadates' do
        it 'is valid' do
          instadate = build(:instadate)
          expect(instadate).to be_valid
        end
      end

      context 'when user has 1 instadate already' do
        it 'is invalid' do
          user = create(:user)
          create(:instadate, creator: user)

          instadate = build(:instadate, creator: user)

          expect(instadate).to be_invalid
        end
      end
    end
  end
end
