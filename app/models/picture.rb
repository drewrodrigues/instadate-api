# frozen_string_literal: true

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

# Picture can be created first, then associated with the user later so we can
# create the record during onboarding previous to the user being created.
class Picture < ApplicationRecord
  before_create :set_verified_to_false

  belongs_to :user, optional: true
  has_one_attached :file

  validates :verified, inclusion: { in: [false, true] }

  private

  def set_verified_to_false
    self.verified = false
  end
end
