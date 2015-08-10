require 'rails_helper'

RSpec.describe "job_scores/index", type: :view do
  before(:each) do
    assign(:job_scores, [
      JobScore.create!(
        :job => "Job"
      ),
      JobScore.create!(
        :job => "Job"
      )
    ])
  end

  it "renders a list of job_scores" do
    render
    assert_select "tr>td", :text => "Job".to_s, :count => 2
  end
end
