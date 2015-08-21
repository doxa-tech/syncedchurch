When(/^I complete group's form with the required fields$/) do
  fill_in "Nom", with: "Conseil d'église"
  select "Conseil", from: "Type"
  select "A l'église", from: "Lieu"
  click_button "Continuer"
end

When(/^I do not complete the group's form$/) do
  click_button "Continuer"
end

Then(/^I should see the group's information$/) do
  expect(page).to have_content "Conseil d'église"
  expect(page).to have_content "A l'église"
  expect(page).to have_content "Conseil"
end