class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.boolean :admin, default: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.text :session_token, null: false
      t.integer :age, null: false
      t.string :location, null: false
      t.string :sex, null: false
      t.string :interested_in, null: false
      t.string :outcome, null: false
      t.string :name, null: false
      t.text :bio, null: false

      t.timestamps
    end
  end
end
