require 'rails_helper'



describe SlackWorker do
  context "worker configuration" do
    it { is_expected.to be_processed_in :slack }
    it { is_expected.to be_retryable 2 }
    it { is_expected.to be_unique }
    it { is_expected.to be_expired_in 3600 }
    
  
    # it 'enqueues SlackWorker job' do
      # SlackWorker.perform_async('SlackWorker')
#   
      # expect(SlackWorker).to have_enqueued_job('SlackWorker')
    # end
  end
  
  
end