# -----------------------------------------------------------------------------
#    Faalis - Basic website skel engine
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
def wait_for_ajax
  Timeout.timeout(Capybara.default_wait_time) do
    active = page.evaluate_script('$("#flash").is(":visible")')
    until active == true
      active = page.evaluate_script('$("#flash").is(":visible")')
    end
  end
end

When(/^fill in "(.*?)" with "(.*?)"$/) do |input, value|
  fill_in input, with: value
end

When(/^click on "(.*?)"$/) do |link|

  click_on link
end

When(/^wait for ajax to return$/) do
  wait_for_ajax
end
Then (/^field "(.+)" contains "(.+)"$/) do |field, value|
  find_field('name').value.should eq value
end
