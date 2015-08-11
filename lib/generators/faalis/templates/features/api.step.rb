Given(/^there is a <%= resource.underscore %> named "(.*?)" in database$/) do |name|
  <%= resource %>.new(:name => name).save!
end

Then(/^there shouldn't be any <%= resource.underscore %>$/) do
  <%= resource %>.all.count.should == 0
end
