class CreateLocationsVersionTwo < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :city
      t.string :address
      t.float :longitude
      t.float :latitude
      t.integer :zoom_level

      t.timestamps null: false
    end
  end
end
