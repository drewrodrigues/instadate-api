# == Schema Information
#
# Table name: interested_ins
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  sex_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class InterestedIn < ApplicationRecord
  belongs_to :user
  belongs_to :sex
end
