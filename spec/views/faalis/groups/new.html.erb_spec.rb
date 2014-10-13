require 'rails_helper'

RSpec.describe "groups/new", :type => :view do
  before(:each) do
    assign(:group, Group.new())
  end

  it "renders new group form" do
    render

    assert_select "form[action=?][method=?]", groups_path, "post" do
    end
  end
end
