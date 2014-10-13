require 'rails_helper'

RSpec.describe "Permissions", :type => :request do
  describe "GET /faalis_permissions" do
    it "works! (now write some real specs)" do
      get faalis_permissions_path
      expect(response).to have_http_status(200)
    end
  end
end
