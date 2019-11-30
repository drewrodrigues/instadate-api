class AddLongitudeAndLatitudeToInstadates < ActiveRecord::Migration[6.0]
  def change
    add_column :instadates, :address, :string, null: false
    add_column :instadates, :city, :string, null: false
    add_column :instadates, :latitude, :float, null: false
    add_column :instadates, :longitude, :float, null: false
    add_index :instadates, :latitude
    add_index :instadates, :longitude
    remove_column :instadates, :location
  end
end
