class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.boolean :admin, default: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :session_token
      t.integer :age, null: false
      t.string :location, null: false

      t.timestamps
    end
  end
end
