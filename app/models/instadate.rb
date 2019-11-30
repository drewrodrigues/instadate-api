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
require 'geocoder'

class Instadate < ApplicationRecord
  extend Geocoder::Model::ActiveRecord

  ACTIVITIES = %w[
    anything
    coffee
    drinks
    food
    hike
    movie
    other
    skating
    tea
    wal
  ].freeze

  belongs_to :creator, class_name: 'User'
  belongs_to :partner, class_name: 'User', optional: true

  validates :activity, inclusion: ACTIVITIES
  validates :latitude, :longitude, presence: true
  validate :only_one_created_date

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.address = geo.address
      obj.city = geo.city
    end
  end
  after_validation :reverse_geocode

  private

  def only_one_created_date
    errors.add(:creator, 'already created a date') if new_record? && date_exists?
  end

  def date_exists?
    Instadate.where(creator: creator).exists?
  end
end
