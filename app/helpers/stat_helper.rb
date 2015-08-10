module StatHelper
  
 
  def self.fetch_users_from_slack
    uriUsers = URI(Rails.configuration.x.slack_users_uri)
    params = { :token => Rails.configuration.x.slack_key}
    uriUsers.query = URI.encode_www_form(params)
    Net::HTTP.start(uriUsers.host, uriUsers.port, :use_ssl => uriUsers.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |httpUsers|
      request = Net::HTTP::Get.new uriUsers

      response = httpUsers.request request
      data = JSON.parse(response.body)['members']
      return data
    end
  end
  
  def self.insert_users(users)
    users.each do |member|
      if !(Stat.where(:name => member['name']).exists?)
        Stat.create(:name=> member['name'])
      end
    end
  end
  
  def self.update_users_messages
    Stat.all.each do |member|
      messages = fetch_messages_for_user(member.name)
      update_messages(member.name, messages)
    end
  end
  
  def self.fetch_messages_for_user(user)
    uriMessages = URI(Rails.configuration.x.slack_search_all_uri)
    params = { :token => Rails.configuration.x.slack_key, :query => 'from:' + user}
    uriMessages.query = URI.encode_www_form(params)
    Net::HTTP.start(uriMessages.host, uriMessages.port, :use_ssl => uriMessages.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |httpMsg|
      request = Net::HTTP::Get.new uriMessages

      response = httpMsg.request request
      dataUser = JSON.parse(response.body)
      return dataUser['messages']["total"]
    end
  end
  
  def self.update_messages(name, count)
    #Delayed::Worker.logger.info(name)
    #Delayed::Worker.logger.info(count)
    Stat.where(:name => name).update_all(:msg_count => count, :msg_count_last_seven_days => count)
  end
  
  
end
