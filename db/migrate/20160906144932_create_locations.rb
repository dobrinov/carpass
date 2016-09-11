class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :city
      t.string :address
      t.string :details
      t.float :longitude
      t.float :latitude
      t.integer :zoom_level
      t.integer :category

      t.timestamps null: false
    end
  end
end
