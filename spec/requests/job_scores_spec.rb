require 'rails_helper'

RSpec.describe "JobScores", type: :request do
  describe "GET /job_scores" do
    it "works! (now write some real specs)" do
      get job_scores_path
      expect(response).to have_http_status(200)
    end
  end
end
