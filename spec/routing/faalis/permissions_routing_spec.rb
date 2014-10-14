require "spec_helper"

module Faalis::API::V1
  RSpec.describe PermissionsController, :type => :routing do
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/permissions").to route_to("permissions#index")
      end

      it "routes to #new" do
        expect(:get => "/permissions/new").to route_to("permissions#new")
      end

      it "routes to #show" do
        expect(:get => "/permissions/1").to route_to("permissions#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/permissions/1/edit").to route_to("permissions#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/permissions").to route_to("permissions#create")
      end

      it "routes to #update" do
        expect(:put => "/permissions/1").to route_to("permissions#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/permissions/1").to route_to("permissions#destroy", :id => "1")
      end

    end
  end
end
