# frozen_string_literal: true

class AddDeniedToSparks < ActiveRecord::Migration[6.0]
  def change
    add_column :sparks, :denied, :boolean, default: false
  end
end
