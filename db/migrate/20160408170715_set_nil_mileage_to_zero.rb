class SetNilMileageToZero < ActiveRecord::Migration
  def up
    execute "UPDATE histories SET mileage = 0 WHERE mileage IS NULL"
  end

  def down
    execute "UPDATE histories SET mileage = NULL WHERE mileage = 0"
  end
end
