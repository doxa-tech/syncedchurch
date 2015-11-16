When(/^I complete the event's form with the required fields$/) do
  fill_in "Description", with: "Soirée vision"
  select_datetime "26 novembre 2015 20h00", from: "event_dtstart"
  select_datetime "26 novembre 2015 22h00", from: "event_dtend"
  click_button "Créer"
end

Then(/^I should see the event's overview$/) do
  expect(page).to have_content "Soirée vision"
end