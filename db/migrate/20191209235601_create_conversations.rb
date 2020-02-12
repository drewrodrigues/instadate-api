# frozen_string_literal: true

class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.integer :accepting_user_id, null: false, foreign_key: true
      t.integer :requesting_user_id, null: false, foreign_key: true

      t.timestamps
    end

    add_index :conversations, %i[accepting_user_id requesting_user_id], unique: true
  end
end
