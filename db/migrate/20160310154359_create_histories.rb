class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :mileage
      t.decimal :cost, precision: 8, scale: 2
      t.string :details
      t.integer :car_id
      t.string :type
      t.datetime :valid_until

      t.timestamps null: false
    end
  end
end
