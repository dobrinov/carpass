class RemoveMakeFromCars < ActiveRecord::Migration
  def change
    remove_column :cars, :make
  end
end
