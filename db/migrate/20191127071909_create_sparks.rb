# frozen_string_literal: true

class CreateSparks < ActiveRecord::Migration[6.0]
  def change
    create_table :sparks do |t|
      t.references :instadate, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :note

      t.timestamps
    end

    add_index :sparks, %i[user_id instadate_id], unique: true
  end
end
