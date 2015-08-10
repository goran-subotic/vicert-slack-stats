require "rails_helper"

RSpec.describe JobScoresController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/job_scores").to route_to("job_scores#index")
    end

    it "routes to #new" do
      expect(:get => "/job_scores/new").to route_to("job_scores#new")
    end

    it "routes to #show" do
      expect(:get => "/job_scores/1").to route_to("job_scores#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/job_scores/1/edit").to route_to("job_scores#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/job_scores").to route_to("job_scores#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/job_scores/1").to route_to("job_scores#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/job_scores/1").to route_to("job_scores#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/job_scores/1").to route_to("job_scores#destroy", :id => "1")
    end

  end
end
