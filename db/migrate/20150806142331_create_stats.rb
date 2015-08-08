class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :name
      t.integer :msg_count
      t.integer :msg_count_last_seven_days

      t.timestamps null: false
    end
  end
end
