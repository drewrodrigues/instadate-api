# frozen_string_literal: true
# == Schema Information
#
# Table name: sparks
#
#  id           :integer          not null, primary key
#  instadate_id :integer          not null
#  user_id      :integer          not null
#  note         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  denied       :boolean          default("false")
#

require 'rails_helper'

RSpec.describe Spark, type: :model do
  subject(:spark) { create(:spark) }

  describe 'associations' do
    it { should belong_to(:instadate) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_length_of(:note).allow_nil }
    it { should validate_uniqueness_of(:instadate).scoped_to(:user_id) }
  end
end
