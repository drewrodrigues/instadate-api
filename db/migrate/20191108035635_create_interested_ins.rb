class CreateInterestedIns < ActiveRecord::Migration[6.0]
  def change
    create_table :interested_ins do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sex, null: false, foreign_key: true

      t.timestamps
    end
  end
end
