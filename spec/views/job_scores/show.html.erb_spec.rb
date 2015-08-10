require 'rails_helper'

RSpec.describe "job_scores/show", type: :view do
  before(:each) do
    @job_score = assign(:job_score, JobScore.create!(
      :job => "Job"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Job/)
  end
end
