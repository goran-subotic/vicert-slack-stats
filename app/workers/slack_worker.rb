class SlackWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :slack
  sidekiq_options :retry => 2
  sidekiq_options :expires_in => 1.hour
  sidekiq_options unique: true

  def perform(name)
    
    users = StatHelper::fetch_users_from_slack
    StatHelper::insert_users(users)
    StatHelper::update_users_messages
    
  end
  
end