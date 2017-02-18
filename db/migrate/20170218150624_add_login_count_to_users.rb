class AddLoginCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login_count, :integer, default: 0, null: false
  end
end
