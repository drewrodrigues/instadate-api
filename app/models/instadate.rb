# == Schema Information
#
# Table name: instadates
#
#  id         :integer          not null, primary key
#  activity   :string           not null
#  location   :string           not null
#  time       :time
#  creator_id :integer          not null
#  partner_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require_relative 'validators/city_validator'

class Instadate < ApplicationRecord
  # constants
  ACTIVITIES = [
    'anything',
    'coffee',
    'drinks',
    'food',
    'hike',
    'ice skating',
    'movie',
    'other',
    'roller skating',
    'tea',
    'walk'
  ].freeze

  # associations
  belongs_to :creator, class_name: 'User'
  belongs_to :partner, class_name: 'User', optional: true

  # validations
  include ActiveModel::Validations
  # - inclusion
  validates :activity, inclusion: ACTIVITIES
  validates :location, city: true
  # - custom
  validate :only_one_created_date

  private

  def only_one_created_date
    errors.add(:creator, 'already created a date') if new_record? && date_exists?
  end

  def date_exists?
    Instadate.where(creator: creator).exists?
  end
end
