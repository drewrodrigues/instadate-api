class CreatePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures do |t|
      t.boolean :verified, null: false, default: false
      t.references :user, null: true, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
