When(/^I complete the form with "(.*?)" and "(.*?)"$/) do |email, password|
  fill_in "Email", with: email
  fill_in "Mot de passe", with: password
  click_button "Se connecter"
end

When(/^I login$/) do
  visit "/login"
  step "there is an user"
  step 'I complete the form with "bruce@wayne.com" and "12341"'
end

Then(/^I should see my name in the sidebar$/) do
  expect(find "#sidebar").to have_content "Bruce Wayne"
end

Then(/^I should not see my name in the sidebar$/) do
  expect(find "#sidebar").not_to have_content "Bruce Wayne"
end