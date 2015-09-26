When(/^I visit the new meeting's page$/) do
  visit new_group_meeting_path(@group)
end

When(/^I complete meeting's form with the required fields$/) do
  select_date "12 juin 2015", from: "meeting_date"
  check "Alfred Dupont"
  click_button "Créer"
end

When(/^I choose a group and I continue$/) do
  select "Conseil d'église", from: "Groupe"
  click_button "Continuer"
end

When(/^I select an external member$/) do
  fill_in_selectized "meeting_external_member_ids", with: "John Smith"
end

When(/^I upload multiple files$/) do
  fill_in "Nom", with: "PV"
  attach_file "Fichier", File.join(Rails.root, '/spec/fixtures/files/pv.pdf')
  click_button "Ajouter un fichier"
  fill_in "meeting_files_attributes_1_name", with: "Document du projet"
  attach_file "meeting_files_attributes_1_file", File.join(Rails.root, '/spec/fixtures/files/projet.pdf')
end

Then(/^I should see the files in the meeting's overview$/) do
  expect(find "#files").to have_content "PV"
  expect(find "#files").to have_content "Document du projet"
end

Then(/^I should see the meeting with the external member$/) do
  expect(find ".member-count").to have_content "2"
end

Then(/^I should see the new meeting's overview$/) do
  expect(page).to have_content "12 juin 2015"
  expect(find ".member-count").to have_content "1"
end

Then(/^I should see the form to create a meeting$/) do
  expect(page).to have_selector "form#new_meeting"
end