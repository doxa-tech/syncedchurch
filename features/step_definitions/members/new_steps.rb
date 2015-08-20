When(/^I complete the member's form with the required fields$/) do
  fill_in "Nom", with: "John"
  fill_in "Prénom", with: "Smith"
  select_date "12 juin 1961", from: "member_birthday"
  select "Homme", from: "Sexe"
  click_button "Créer" 
end

When(/^I add phone numbers$/) do
  fill_in "Numéro", with: "079 480 08 08"
  select "Travail", from: "Type"
  click_button "Ajouter un numéro"
  fill_in "member_phones_attributes_1_number", with: "026 912 91 73"
  select "Domicile", from: "member_phones_attributes_1_phone_type"
end

When(/^I add the member in a new family$/) do
  fill_in "Famille", with: "Johnson"
  select "Père", from: "Place dans la famille"
end

When(/^I mark fields as private$/) do
  fill_in "Email", with: "john@son.com"
  find(:xpath, "//input[@type='checkbox' and @value='email']").set(true)
  find(:xpath, "//input[@type='checkbox' and @value='birthday']").set(true)
end

Then(/^I should see the member's phone numbers$/) do
  expect(page).to have_content "079 480 08 08"
  expect(page).to have_content "026 912 91 73"
end

Then(/^I should see the member's information$/) do
  expect(page).to have_content "Smith John"
  expect(page).to have_content "12 juin 1961"
  expect(page).to have_content "Homme"
end

Then(/^I should see the member's family$/) do
  expect(page).to have_content "Père dans la famille Johnson"
end

Then(/^I should not see the private information in the public list$/) do
  visit "/list"
  expect(page).to have_content "Smith John"
  expect(page).not_to have_content "john@son.com"
  expect(page).not_to have_content "12 juin 1961"
end