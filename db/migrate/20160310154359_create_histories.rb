class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :mileage
      t.string :details
      t.integer :car_id
      t.string :type

      t.timestamps null: false
    end
  end
end
