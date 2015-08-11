module JobScoresHelper
  
  #Update statistics for delayed job, after execution is complete
  #Update status and completion time of the job
  def self.update_job_status(job_id, status)
    js = JobScore.where(:job_id => job_id).first
    js.status = status
    js.end_time = Time.now
    js.save!
  end
  
end
