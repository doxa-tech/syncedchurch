When(/^I visit the edit page of the group$/) do
  visit edit_group_path(@group)
end

When(/^I change the name of the group with "(.*?)"$/) do |value|
  fill_in "Nom", with: value
  click_button "Enregistrer"
end

When(/^I choose a member and add him$/) do
  fill_in_selectized "member_id", with: "John Smith"
  select "Responsable", from: "Status"
  click_button "Ajouter"
end

When(/^I click the button to delete a member of the group$/) do
  click_link "delete-member"
end

Then(/^I should see the updated name of the group$/) do
  visit current_path
  expect(page).to have_field "Nom", with: "Conseil exécutif"
end

When(/^I click the button to toggle the status of a member$/) do
  click_link "toggle-member-status"
end

Then(/^I should see the member "(.*?)" in the list$/) do |name|
  expect(find ".member:last-child").to have_content name
  expect(find ".member:last-child").to have_content "Responsable"
end

Then(/^the member should not be anymore in the group$/) do
  expect(find "#members").not_to have_content "Alfred Dupont"
end

Then(/^the status of the member should have changed$/) do
  expect(find "#members").to have_content "Responsable"
  expect(find "#members").not_to have_content "Membre"
end