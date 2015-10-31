When(/^I complete the form with a new password$/) do
  fill_in "Mot de passe actuel", with: "12341"
  fill_in "Mot de passe", with: "rainbow_dash"
  fill_in "Confirmation", with: "rainbow_dash"
  click_button "Enregistrer"
end

When(/^I complete the form without the current password$/) do
  fill_in "Mot de passe", with: "rainbow_dash"
  fill_in "Confirmation", with: "rainbow_dash"
  click_button "Enregistrer"
end

Then(/^I should be able to log in with my new password$/) do
  step "I logout"
  visit "/login"
  step 'I complete the form with "bruce@wayne.com" and "rainbow_dash"'
  step "I should see my name in the sidebar"
end