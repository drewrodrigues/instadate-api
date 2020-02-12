# frozen_string_literal: true

class AllowMultipleInterestedInOnUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :interested_in, :string, array: true, default: [], using: "(string_to_array(interested_in, ','))"
  end
end
