# == Schema Information
#
# Table name: sexes
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sex < ApplicationRecord
  validates :name, presence: true
end
