class RemoveMsgCountLastSevenDaysFromStats < ActiveRecord::Migration
  def change
    remove_column :stats, :msg_count_last_seven_days, :integer
  end
end
