# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  verified   :boolean          default("false"), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pictures_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Picture, type: :model do
  describe 'defaults' do
    context 'when new record' do
      it 'sets verified to false' do
        picture = Picture.new

        expect(picture.verified).to be(false)
      end
    end

    context 'when old record' do
      context 'with verified set to true' do
        it 'doesn\'t change verified back to false' do
          picture = create(:picture)

          picture.verified = true
          picture.save

          expect(picture.reload.verified).to be(true)
        end
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:user).optional }
  end

  describe 'validations' do
    it { should validate_inclusion_of(:verified).in_array([false, true]) }
  end
end
