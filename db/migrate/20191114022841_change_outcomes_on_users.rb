class ChangeOutcomesOnUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :outcome, :string, array: true, default: [], using: "(string_to_array(outcome, ','))"
    rename_column :users, :outcome, :outcomes
  end
end
