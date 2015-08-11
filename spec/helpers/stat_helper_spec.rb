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

    mock_response = File.join(Rails.root, 'spec', 'webmock', 'slack_com_api_search_all.json')
    mr = File.open(mock_response)

    stub_request(:get, Regexp.new(Regexp.escape(Rails.configuration.x.slack_search_all_uri))).
        with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(status: 200, body: mr, headers: {})
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

  describe "#fetch_messages_for_user" do
    it "fetches collection of Slack messages for user" do
      result = StatHelper::fetch_messages_for_user("rspec_test_user_1")

      expect(result).to_not be_nil

    end
  end

end
