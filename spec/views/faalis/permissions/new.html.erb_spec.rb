require 'rails_helper'

RSpec.describe "permissions/new", :type => :view do
  before(:each) do
    assign(:permission, Permission.new())
  end

  it "renders new permission form" do
    render

    assert_select "form[action=?][method=?]", permissions_path, "post" do
    end
  end
end
