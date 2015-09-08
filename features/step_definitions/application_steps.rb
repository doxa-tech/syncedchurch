Given(/^there are members in the church$/) do
  @member = create(:member)
end

Given(/^there is a group$/) do
  @group = create(:group)
end

When(/^I visit "(.*?)"$/) do |path|
  visit path
end

When(/^I do not complete the form$/) do
  click_button "Créer"
end

Then(/^I should see a flash containing "(.*?)"$/) do |message|
  expect(find '#flash').to have_content(message)
end

Then /^I should see errors for the fields "(.*?)"$/ do |fields|
  fields.split(",").each do |field|
    expect(find '#errors').to have_content field
  end
end