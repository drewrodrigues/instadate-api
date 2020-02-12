# frozen_string_literal: true

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
#  sex             :string           not null
#  interested_in   :string           default("{}"), not null, is an Array
#  outcomes        :string           default("{}"), not null, is an Array
#  name            :string           not null
#  bio             :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  latitude        :float            not null
#  longitude       :float            not null
#  city            :string           not null
#
# Indexes
#
#  index_users_on_city       (city)
#  index_users_on_latitude   (latitude)
#  index_users_on_longitude  (longitude)
#

class User < ApplicationRecord
  extend Geocoder::Model::ActiveRecord

  INTERESTED_IN_OPTIONS = %w[man woman].freeze

  def available_dates
    # TODO: pull out and chain queries
    Instadate.includes(:creator)
             .where.not(users: { id: id }) # not my created date
             .where(users: { sex: interested_in }) # I'm interested in them
             .where('? = ANY(users.interested_in)', sex) # they're interested in me
  end

  def conversations
    Conversation.where('accepting_user_id = :id OR requesting_user_id = :id', id: id)
  end

  def pending_sparks
    received_sparks.where(denied: false)
  end

  after_initialize :ensure_session_token

  has_one :created_instadate,
          inverse_of: :creator,
          class_name: 'Instadate',
          foreign_key: 'creator_id',
          dependent: :destroy
  has_one :picture, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :sent_sparks,
           class_name: 'Spark',
           dependent: :destroy
  has_many :received_sparks,
           through: :created_instadate,
           source: :sparks,
           dependent: :destroy

  validates :bio, length: { in: 0..200 }
  validates :password, length: { minimum: 8 }, allow_nil: true
  validates :email,
            :age,
            :bio,
            :latitude,
            :longitude,
            :session_token,
            :outcomes,
            :sex,
            :name,
            presence: true
  validates :email, 'valid_email_2/email': true
  validates :age, inclusion: 18..100
  validate :valid_interested_in
  validate :valid_outcomes
  validates :sex, inclusion: %w[man woman]
  validates :email, uniqueness: { case_sensitive: false }

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.city = geo.city
    end
  end
  after_validation :reverse_geocode

  has_secure_password

  def authenticate_password(password)
    reset_session_token! if super(password)
    self
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.base64
  end

  def set_session_token
    self.session_token = SecureRandom.base64
  end

  def reset_session_token!
    set_session_token
    save
  end

  def valid_outcomes
    return if outcomes_not_empty? && each_outcome_valid?

    errors.add(:outcomes, 'is invalid')
  end

  def valid_interested_in
    return if interested_in_not_empty? && each_interested_in_valid?

    errors.add(:interested_in, 'is invalid')
  end

  def interested_in_not_empty?
    !interested_in.empty?
  end

  def outcomes_not_empty?
    !outcomes.empty?
  end

  def each_outcome_valid?
    valid_outcomes = %w[dating hookups relationship]
    outcomes.all? { |outcome| valid_outcomes.include?(outcome) }
  end

  def each_interested_in_valid?
    interested_in.all? { |interest| INTERESTED_IN_OPTIONS.include?(interest) }
  end
end
