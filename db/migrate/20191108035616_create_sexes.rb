class CreateSexes < ActiveRecord::Migration[6.0]
  def change
    create_table :sexes do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
