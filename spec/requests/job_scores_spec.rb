require 'rails_helper'

RSpec.describe "JobScores", type: :request do
  describe "GET /job_scores" do
    it "works!" do
      get job_scores_path
      expect(response).to have_http_status(302)
    end
  end
end
