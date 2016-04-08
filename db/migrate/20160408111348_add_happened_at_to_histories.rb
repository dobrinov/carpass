class AddHappenedAtToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :happened_at, :datetime
  end
end
