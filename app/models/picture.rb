# Picture can be created first, then associated with the user later so we can
# create the record during onboarding previous to the user being created.
class Picture < ApplicationRecord
  # callbacks
  before_create :set_verified_to_false

  # associations
  belongs_to :user, optional: true

  # attachments
  has_one_attached :file

  # validations
  validates :verified, inclusion: { in: [false, true] }

  private

  def set_verified_to_false
    self.verified = false
  end
end