require 'rails_helper'

RSpec.describe "job_scores/new", type: :view do
  before(:each) do
    assign(:job_score, JobScore.new(
      :job => "MyString"
    ))
  end

  it "renders new job_score form" do
    render

    assert_select "form[action=?][method=?]", job_scores_path, "post" do

      assert_select "input#job_score_job[name=?]", "job_score[job]"
    end
  end
end
