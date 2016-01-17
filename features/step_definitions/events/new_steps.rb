When(/^I complete the event's form with the required fields$/) do
  fill_in "Titre", with: "Soirée vision"
  fill_in "Lieu", with: "EEBulle"
  fill_in "event_dstart", with: "26.11.2015"
  fill_in "event_tstart", with: "20:00"
  fill_in "event_dend", with: "26.11.2015"
  fill_in "event_tend", with: "22:00"
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
