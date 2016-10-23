class AddBrandIdToCars < ActiveRecord::Migration
  def change
    add_column :cars, :brand_id, :integer
    add_index :cars, :brand_id
  end
end
