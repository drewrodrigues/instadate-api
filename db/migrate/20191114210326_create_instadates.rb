class CreateInstadates < ActiveRecord::Migration[6.0]
  def change
    create_table :instadates do |t|
      t.string :activity, null: false
      t.string :location, null: false
      t.time :time
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :partner, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
