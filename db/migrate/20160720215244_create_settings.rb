class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :user_id
      t.boolean :receives_history_expiration_emails, default: true
      t.boolean :receives_inactivity_emails, default: true
      t.boolean :receives_history_expiration_facebook_notifications, default: true
      t.boolean :receives_inactivity_facebook_notifications, default: true
    end
  end
end
