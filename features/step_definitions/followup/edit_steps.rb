When(/^I visit the followup edit path$/) do
  @followup = create(:followup)
  visit edit_followup_path(@followup)
end

When(/^I change the duration of the meeting$/) do
  fill_in "Durée", with: 60
  click_button "Enregistrer"
end

Then(/^I should see the updated duration$/) do
  expect(page).to have_field "Durée", with: 60
end