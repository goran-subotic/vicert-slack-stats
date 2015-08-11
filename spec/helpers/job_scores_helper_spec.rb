require 'rails_helper'

RSpec.describe JobScoresHelper, type: :helper do


  describe "#update_job_status" do
    it "updates status of a job" do

      job_score = JobScore.create(name: "Rspec Test Job", status: "started")
      JobScoresHelper::update_job_status(job_score.job_id, "success")
      job_score.reload()
      expect(job_score.status).to eq("success")

    end
  end

end
