class CreateJobScores < ActiveRecord::Migration
  def change
    create_table :job_scores do |t|
      t.integer :job_id
      t.string :name
      t.timestamp :start_time
      t.timestamp :end_time
      t.string :status
      t.timestamps null: false
    end
  end
end
