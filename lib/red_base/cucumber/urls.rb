# -----------------------------------------------------------------------------
#    Red Base - Basic website skel engine
#    Copyright (C) 2012-2013 Yellowen
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
# -----------------------------------------------------------------------------

# Some useful steps for cucumber scenarios
Then /^I should be on (.+?)$/ do |page_name|
  current_path.should == path_to(page_name)
  response.should be_success
end

Then(/^I should redirect to (.+?)$/) do |path_name|
  #puts "<<<<<<< ", current_path, page.driver.headers('HTTP_REFERER')
  #request.headers['HTTP_REFERER'].should_not be_nil
  #page.status_code.should == 302
  Then "I should be on #{path_name}"
end

#When(/^I go to (.*?) using (.*?) format$/) do |path_name, format|
#  visit "#{path_to(path_name)}.#{format}"
#end

When(/^I go to (.+)$/) do |path_name|
  begin
    visit "#{path_to(path_name)}"
  rescue ActionController::UnknownFormat => e
    @exception = e
  end
end

When(/^format is (.+) and I go to (.+)$/) do |format, path_name|
  begin
    visit "#{path_to(path_name)}.#{format}"
  rescue ActionController::UnknownFormat => e
    @exception = e
  end
end
Then(/^I should get "(.*?)" status code$/) do |status_code|
  page.status_code.should == status_code.to_i
end

Then(/^response type should be (.+?)$/) do |response_type|
   page.response_headers['Content-Type'].should include(response_type)
end

Then(/^I should get unknown format exception$/) do
  @exception.should_not be_nil
  @exception.class.should be(ActionController::UnknownFormat)
end
