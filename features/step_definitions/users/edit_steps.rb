When(/^I complete the form with a new password$/) do
  fill_in "Mot de passe", with: "rainbow_dash"
  fill_in "Confirmation", with: "rainbow_dash"
  click_button "Enregistrer"
end

Then(/^I should be able to log in with my new password$/) do
  pending # express the regexp above with the code you wish you had
end