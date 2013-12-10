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
Given(/^I am not authenticated$/) do
  page.driver.submit :delete, "/users/sign_out", {}
end


Given(/^I am authenticated$/) do
  group = RedBase::Group.new(:name => "admin")
  group.save!
  email = 'admin@example.com'
  password = '123123123'
  RedBase::User.new(:email => email, :password => password, :password_confirmation => password,
           :group => group).save!

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"
end

Then(/^I should be in sign in page$/) do
  should have_content("Sign in")
end
