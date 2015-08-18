When(/^I complete the member form with the required fields$/) do
  fill_in "Nom", with: "John"
  fill_in "Prénom", with: "Smith"
  select_date "12 juin 1961", from: "member_birthday"
  select "Homme", from: "Sexe"
  click_button "Créer" 
end

When(/^I add phone numbers$/) do
  fill_in "Numéro", with: "079 480 08 08"
  select "Privé", from: "Type"
  click_button "Ajouter un numéro"
  fill_in "member_phones_attributes_1_number", with: "026 912 91 73"
  select "Domicile", from: "member_phones_attributes_1_phone_type_id"
end

Then(/^I should see the member phone numbers$/) do
  expect(page).to have_content "079 480 08 08"
  expect(page).to have_content "026 912 91 73"
end

Then(/^I should see the member's information$/) do
  expect(page).to have_content "John"
  expect(page).to have_content "Smith"
  expect(page).to have_content "12 juin 1961"
  expect(page).to have_content "Homme"
end