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
# Indexes
#
#  index_sparks_on_instadate_id              (instadate_id)
#  index_sparks_on_user_id                   (user_id)
#  index_sparks_on_user_id_and_instadate_id  (user_id,instadate_id) UNIQUE
#

class Spark < ApplicationRecord
  belongs_to :instadate
  belongs_to :user

  validates :note, length: { maximum: 120 }, allow_nil: true
  validates :instadate, uniqueness: { scope: :user_id }
end
