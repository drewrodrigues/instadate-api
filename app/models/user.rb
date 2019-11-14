# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  admin           :boolean          default("0")
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :text(65535)      not null
#  age             :integer          not null
#  location        :string(255)      not null
#  sex             :string(255)      not null
#  interested_in   :string(255)      not null
#  outcome         :string(255)      not null
#  bio             :text(65535)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  # class methods
  def self.valid_cities
    @@valid_cities ||= CS.states(:us).keys.flat_map do |state|
      CS.cities(state, :us).flat_map { |city| "#{city}, #{state}"}
    end
  end

  # callbacks
  after_initialize :ensure_session_token

  # associations
  has_one :picture, dependent: :destroy

  # validations
  # - presence
  validates :email,
            :age,
            :bio,
            :location,
            :session_token,
            :outcomes,
            :interested_in,
            :sex,
            :name,
            presence: true
  # - inclusion
  validates :age, inclusion: 18..100
  validates :interested_in, inclusion: %w[men women both]
  validate :valid_outcomes
  validate :valid_location
  validates :sex, inclusion: %w[man woman]
  # - uniqueness
  validates :email, uniqueness: { case_sensitive: false }

  # auth
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

  def outcomes_not_empty?
    !outcomes.empty?
  end

  def each_outcome_valid?
    valid_outcomes = %w[dating hookups relationship]
    outcomes.all? { |outcome| valid_outcomes.include?(outcome) }
  end
end
