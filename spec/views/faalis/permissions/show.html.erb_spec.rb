require 'rails_helper'

RSpec.describe "permissions/show", :type => :view do
  before(:each) do
    @permission = assign(:permission, Permission.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
