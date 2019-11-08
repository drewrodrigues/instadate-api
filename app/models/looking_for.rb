# == Schema Information
#
# Table name: looking_fors
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  outcome_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LookingFor < ApplicationRecord
  belongs_to :user
  belongs_to :outcome
end
