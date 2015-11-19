When(/^I complete the event's form with the required fields$/) do
  fill_in "Description", with: "Soirée vision"
  select_datetime "26 novembre 2015 20h00", from: "event_dtstart"
  select_datetime "26 novembre 2015 22h00", from: "event_dtend"
  click_button "Créer"
end

When(/^I set a monthly recurrence for ten times$/) do
  select "Chaque mois", from: "event_recurrence_frequence"
  fill_in "Nombre de fois", with: "10"
end

Then(/^I should see the recurrence in the event's overview$/) do
  expect(page).to have_content "Chaque mois, 10 fois"
end

Then(/^I should see the event's overview$/) do
  expect(page).to have_content "Soirée vision"
end