class AddMakeAndModelToCar < ActiveRecord::Migration
  def change
    add_column :cars, :make, :string
    add_column :cars, :model, :string
  end
end
