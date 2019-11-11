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
  # callbacks
  after_initialize :set_session_token

  # validations
  validates :email,
            :age,
            :bio,
            :location,
            :session_token,
            :outcome,
            :interested_in,
            :sex,
            :name,
            presence: true
  validates :email, uniqueness: { case_sensitive: true }

  # auth
  has_secure_password

  def authenticate_password(password)
    reset_session_token! if super(password)
  end

  private

  def set_session_token
    self.session_token ||= SecureRandom.base64
  end

  def reset_session_token!
    set_session_token
    save
  end
end
