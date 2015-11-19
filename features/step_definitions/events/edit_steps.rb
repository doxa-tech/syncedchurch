When(/^I visit the event edit path$/) do
  @event = create(:event)
  visit edit_event_path(@event)
end

When(/^I change the description of the event$/) do
  fill_in "Description", with: "Conseil d'église"
  click_button "Enregistrer"
end

Then(/^I should see the updated description$/) do
  expect(page).to have_field "Description", with: "Conseil d'église"
end