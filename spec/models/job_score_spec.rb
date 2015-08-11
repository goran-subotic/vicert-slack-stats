require 'rails_helper'

RSpec.describe JobScore, type: :model do
  
  it 'persists a job_score object' do
    js = JobScore.create(:job_id => 1, :name => 'Job')
    expect(js).to be_persisted
  end
  
end
