require 'rails_helper'

RSpec.describe "job_scores/edit", type: :view do
  before(:each) do
    @job_score = assign(:job_score, JobScore.create!(
      :job => "MyString"
    ))
  end

  it "renders the edit job_score form" do
    render

    assert_select "form[action=?][method=?]", job_score_path(@job_score), "post" do

      assert_select "input#job_score_job[name=?]", "job_score[job]"
    end
  end
end
