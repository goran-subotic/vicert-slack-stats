json.array!(@job_scores) do |job_score|
  json.extract! job_score, :id, :name, :status  :start_time, :end_time
  json.url job_score_url(job_score, format: :json)
end
