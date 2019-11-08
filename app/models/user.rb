# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  admin           :boolean          default("0")
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  age             :integer          not null
#  location        :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  sex_id          :integer          not null
#

class User < ApplicationRecord
  # associations
  belongs_to :sex
  has_many :interested_ins, dependent: :destroy
  has_many :interested_sexes, through: :interested_ins, source: :sex
  has_many :looking_fors, dependent: :destroy
  has_many :looking_for_outcomes, through: :looking_fors, source: :outcome

  # validations
  validates :email, :password, :age, :location, presence: true
  validates :email, uniqueness: { case_sensitive: true }

  # auth
  has_secure_password
end
