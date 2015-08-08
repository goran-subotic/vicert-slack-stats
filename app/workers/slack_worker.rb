class SlackWorker
  include Sidekiq::Worker

  def perform(name)
    uriUsers = URI('https://slack.com/api/users.list')
    uriMessages = URI('https://slack.com/api/search.all')
    params = { :token => Rails.configuration.x.slack_key}
    uriUsers.query = URI.encode_www_form(params)

    Net::HTTP.start(uriUsers.host, uriUsers.port, :use_ssl => uriUsers.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |httpUsers|
      request = Net::HTTP::Get.new uriUsers

      response = httpUsers.request request
    
      data = JSON.parse(response.body)
      data['members'].each do |member|
        if !(Stat.where(:name => member['name']).exists?)
          Stat.create(:name=> member['name'])
        end
        params = { :token => Rails.configuration.x.slack_key, :query => 'from:'+member['name']}
        uriMessages.query = URI.encode_www_form(params)
        Net::HTTP.start(uriMessages.host, uriMessages.port, :use_ssl => uriMessages.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |httpMsg|
          request = Net::HTTP::Get.new uriMessages

          response = httpMsg.request request
    
          dataUser = JSON.parse(response.body)
          Stat.where(:name => member['name']).update_all(:msg_count => dataUser['messages']["total"], :msg_count_last_seven_days => dataUser['messages']["total"])
        end
      end
    end
  end
end