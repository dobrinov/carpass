class ChangeDefaultSettingValues < ActiveRecord::Migration
  def up
    change_column_default :settings, :receives_history_expiration_emails, false
    change_column_default :settings, :receives_inactivity_emails, false
  end

  def down
    change_column_default :settings, :receives_history_expiration_emails, true
    change_column_default :settings, :receives_inactivity_emails, true
  end
end
