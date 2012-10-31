Given /^(\d+) episodes exist$/ do |episode_count|
  (0...episode_count.to_i).each do
    create(:episode)
  end
end

When /^I view the episodes index$/ do
  visit episodes_path
end

Then /^I should see (\d+) fancy rows$/ do |row_count|
  page.all('table.fancy_table tbody tr').count.should == row_count.to_i
end
