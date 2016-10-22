class AddStatusToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :status, :string, null: false, default: 0
  end
end
