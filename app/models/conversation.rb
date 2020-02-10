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
# Indexes
#
#  index_conversations_on_accepting_user_id_and_requesting_user_id  (accepting_user_id,requesting_user_id) UNIQUE
#

class Conversation < ApplicationRecord
  belongs_to :accepting_user, class_name: 'User'
  belongs_to :requesting_user, class_name: 'User'

  def messages_left
    # TODO: implement once messages are in place
    9
  end

  def other_user(current_user)
    current_user == accepting_user ? requesting_user : accepting_user
  end
end
