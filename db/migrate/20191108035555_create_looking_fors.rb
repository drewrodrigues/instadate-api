class CreateLookingFors < ActiveRecord::Migration[6.0]
  def change
    create_table :looking_fors do |t|
      t.references :user, null: false, foreign_key: true
      t.references :outcome, null: false, foreign_key: true

      t.timestamps
    end
  end
end
