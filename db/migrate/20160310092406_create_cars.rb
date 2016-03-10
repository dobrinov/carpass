class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :vin
      t.string :plate
      t.string :engine_number
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
