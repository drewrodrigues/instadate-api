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

class User < ApplicationRecord
  INTERESTED_IN_OPTIONS = %w[man woman].freeze

  def self.valid_cities
    # TODO: use validator instead
    @@valid_cities ||= CS.states(:us).keys.flat_map do |state|
      CS.cities(state, :us).flat_map { |city| "#{city}, #{state}" }
    end
  end

  def available_dates
    # TODO: pull out and chain queries
    Instadate.includes(:creator)
             .where.not(users: { id: id }) # not my created date
             .where(users: { sex: interested_in }) # I'm interested in them
             .where('? = ANY(users.interested_in)', sex) # they're interested in me
  end

  def pending_sparks
    received_sparks.where(denied: false)
  end

  after_initialize :ensure_session_token

  has_one :created_instadate,
          inverse_of: :creator,
          class_name: 'Instadate',
          foreign_key: 'creator_id'
  has_one :picture, dependent: :destroy
  has_many :sent_sparks,
           class_name: 'Spark',
           dependent: :destroy
  has_many :received_sparks,
           through: :created_instadate,
           source: :sparks


  validates :bio, length: { in: 0..200 }
  validates :password, length: { minimum: 8 }, allow_nil: true
  validates :email,
            :age,
            :bio,
            :location,
            :session_token,
            :outcomes,
            :sex,
            :name,
            presence: true
  validates :email, 'valid_email_2/email': true
  validates :age, inclusion: 18..100
  validate :valid_interested_in
  validate :valid_outcomes
  validate :valid_location
  validates :sex, inclusion: %w[man woman]
  validates :email, uniqueness: { case_sensitive: false }

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

  def valid_location
    errors.add(:location, 'is invalid') unless User.valid_cities.include?(location)
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
