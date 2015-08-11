require 'rails_helper'
#require 'stat_helper'

# Specs in this file have access to a helper object that includes
# the StatHelper. For example:
#
# describe StatHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe StatHelper, type: :helper do

  # before(:each) do
  #   stub_request(:get, /https:\/\/slack.com\/api\/search.all/).
  #       with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
  #       to_return(status: 200, body: "stubbed response", headers: {})
  # end

  before(:each) do

    messages_response = File.open(File.join(Rails.root, 'spec/webmock/slack_com_api_search_all.json'))
    users_response = File.open(File.join(Rails.root, 'spec/webmock/slack_com_api_users_list.json'))


    stub_request(:get, Regexp.new(Regexp.escape(Rails.configuration.x.slack_search_all_uri))).
        with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(status: 200, body: messages_response, headers: {})

    stub_request(:get, Regexp.new(Regexp.escape(Rails.configuration.x.slack_users_uri))).
        with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(status: 200, body: users_response, headers: {})
  end

  describe "#fetch_users_from_slack" do
    it "fetches list of users from Slack account" do

      result = StatHelper::fetch_users_from_slack()

      expect(result.count).to eq(40)
    end
  end

  describe "#insert_users" do
     it "persists a list of user data into stats table" do

       member1 = {"name" => :rspec_test_user_1, "profile" => { "real_name" => "Rspec Test User One"}}
       member2 = {"name" => :rspec_test_user_2, "profile" => { "real_name" => "Rspec Test User Two"}}
       stats = [member1, member2]
       StatHelper::insert_users(stats)

       stat_1 = Stat.find_by_name(:rspec_test_user_1)
       stat_2 = Stat.find_by_name(:rspec_test_user_2)

       expect(stat_1).to_not be_nil
       expect(stat_2).to_not be_nil

     end
  end

  describe "#update_users_messages" do
    it "iterates through all stat records and updates the msg_count values" do

      Stat.create(name: "rspec.test.user1", msg_count: 10)
      Stat.create(name: "rspec.test.user2", msg_count: 10)

      StatHelper::update_users_messages()

      Stat.all.each do |stat|
        expect(stat.msg_count).to eq(116)
      end

    end
  end

  describe "#fetch_messages_for_user" do
    it "fetches collection of Slack messages for a user" do

      result = StatHelper::fetch_messages_for_user("rspec_test_user_1")
      expect(result).to eq(116)

    end
  end

  describe "#update_messages" do
    it "updates message count for a user" do

      stat = Stat.create(name: "rspec.test.user", msg_count: 10)
      StatHelper::update_messages("rspec.test.user", 50)
      stat.reload()
      expect(stat.msg_count).to eq(50)

    end
  end

end
