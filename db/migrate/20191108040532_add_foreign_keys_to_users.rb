class AddForeignKeysToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :sex, null: false, foreign_key: true
  end
end
