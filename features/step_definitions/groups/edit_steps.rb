When(/^I visit the edit page of a group$/) do
  group = create(:group)
  visit edit_group_path(group)
end

When(/^I change the name of the group with "(.*?)"$/) do |value|
  fill_in "Nom", with: value
  click_button "Enregistrer"
end

Then(/^I should see the updated name of the group$/) do
  visit current_path
  expect(page).to have_field "Nom", with: "Conseil exécutif"
end