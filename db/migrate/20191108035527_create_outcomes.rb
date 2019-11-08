class CreateOutcomes < ActiveRecord::Migration[6.0]
  def change
    create_table :outcomes do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
