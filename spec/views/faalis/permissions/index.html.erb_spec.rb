require 'rails_helper'

RSpec.describe "permissions/index", :type => :view do
  before(:each) do
    assign(:permissions, [
      Permission.create!(),
      Permission.create!()
    ])
  end

  it "renders a list of permissions" do
    render
  end
end
