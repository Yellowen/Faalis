require 'rails_helper'

RSpec.describe "groups/index", :type => :view do
  before(:each) do
    assign(:groups, [
      Group.create!(),
      Group.create!()
    ])
  end

  it "renders a list of groups" do
    render
  end
end
