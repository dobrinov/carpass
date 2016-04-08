class RenameHistories < ActiveRecord::Migration
  def up
    execute "UPDATE histories SET type = 'ProductionHistory' WHERE type = 'DateOfProduction'"
    execute "UPDATE histories SET type = 'PurchaseHistory' WHERE type = 'DateOfPurchase'"
  end

  def down
    execute "UPDATE histories SET type = 'DateOfProduction' WHERE type = 'ProductionHistory'"
    execute "UPDATE histories SET type = 'DateOfPurchase' WHERE type = 'PurchaseHistory'"
  end
end
