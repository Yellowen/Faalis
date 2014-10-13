require 'rails_helper'

RSpec.describe "permissions/edit", :type => :view do
  before(:each) do
    @permission = assign(:permission, Permission.create!())
  end

  it "renders the edit permission form" do
    render

    assert_select "form[action=?][method=?]", permission_path(@permission), "post" do
    end
  end
end
