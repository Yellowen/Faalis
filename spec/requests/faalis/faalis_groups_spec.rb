require 'spec_helper'

RSpec.describe "Groups", :type => :request do
  describe "GET /faalis_groups" do
    it "works! (now write some real specs)" do
      get faalis_groups_path
      expect(response).to have_http_status(200)
    end
  end
end
