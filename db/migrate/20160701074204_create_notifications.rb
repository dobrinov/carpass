class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :notifiable_id
      t.string  :notifiable_type
      t.timestamp :read_at
      t.string :type

      t.timestamps null: false
    end

    add_index :notifications, [:notifiable_id, :notifiable_type]
  end
end
