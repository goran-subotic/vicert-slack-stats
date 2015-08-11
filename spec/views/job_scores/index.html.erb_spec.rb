require 'rails_helper'

RSpec.describe "job_scores/index", type: :view do
  before(:each) do
    assign(:job_scores, [
      JobScore.create!(
        :job_id => 1,
        :name => "Job",
        :start_time => Time.now,
        :end_time => Time.now,
        :status => "success"
      ),
      JobScore.create!(
        :job_id => 2,
        :name => "Job",
        :start_time => Time.now,
        :end_time => Time.now,
        :status => "success"
      )
    ])
  end

  it "renders a list of job_scores" do
    allow(view).to receive_messages(:will_paginate => nil)
    render
    assert_select "tr>td", :text => "Job".to_s, :count => 2
  end
end
