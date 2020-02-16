# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id                 :integer          not null, primary key
#  accepting_user_id  :integer          not null
#  requesting_user_id :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Conversation < ApplicationRecord
  belongs_to :accepting_user, class_name: 'User'
  belongs_to :requesting_user, class_name: 'User'

  has_many :messages, dependent: :destroy

  def messages_left
    messages.count
  end

  def last_message
    messages.last
  end

  def other_user(current_user)
    current_user == accepting_user ? requesting_user : accepting_user
  end
end
