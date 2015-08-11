require 'rails_helper'

RSpec.describe StatController, type: :controller do

  include Devise::TestHelpers

  before(:each) do
    user = FactoryGirl.create(:user)
    puts user
    sign_in user
  end

  # This should return the minimal set of attributes required to create a valid
  # JobScore. As you add validations to JobScore, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
        :job_id => 1,
        :name => "test",
        :start_time => Time.now
    }
    #skip("Add a hash of attributes valid for your model")
  }

  describe "GET #index" do
    it "lists a list of top users" do

      per_page = 5

      user_list = Array.new
      
      per_page.times do
        user_list.push(FactoryGirl.create(:stat))
      end

      #Sort the array and return first per_page values
      user_list = user_list.sort_by {|stat| -stat.msg_count}[0 .. per_page-1]

      get :index, {:per_page => per_page}
      expect(assigns(:stats_all_time)).to eq(user_list)
    end
  end

end
