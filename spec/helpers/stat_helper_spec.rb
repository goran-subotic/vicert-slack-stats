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

  describe "#insert_users" do
     it "persists a list of stats" do

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

end
