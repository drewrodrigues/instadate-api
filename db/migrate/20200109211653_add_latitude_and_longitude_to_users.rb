# frozen_string_literal: true

class AddLatitudeAndLongitudeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :latitude, :float, null: false
    add_column :users, :longitude, :float, null: false
    add_column :users, :city, :string, null: false
    remove_column :users, :location

    add_index :users, :latitude
    add_index :users, :longitude
    add_index :users, :city
  end
end
