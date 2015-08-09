module SlackData
  
  CollectSlackUsersJob = Struct.new(:job_name) do
    
    def perform
      users = StatHelper::fetch_users_from_slack
      StatHelper::insert_users(users)
    end 
     
  end
  
  CollectSlackMessagesJob = Struct.new(:job_name) do
    
    def perform
      StatHelper::update_users_messages
    end
    
  end
  
end