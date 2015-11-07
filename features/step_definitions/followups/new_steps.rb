When(/^I complete followup's form with the required fields$/) do
  create(:group_member)

  fill_in_selectized "followup_member_id", with: "John Smith"
  fill_in_selectized "followup_counselor_id", with: "Alfred Dupont"
  select_date "12 juin 2015", from: "followup_date"
  select "Rencontre fraternelle", from: "Motif"
  select "Domicile", from: "Lieu de rencontre"
  fill_in "Durée", with: "20"
  fill_in "Notes", with: "Très bon partage"
  click_button "Créer"
end

Then(/^I should see the new followup's overview$/) do
  expect(page).to have_content "John Smith"
  expect(page).to have_content "Alfred Dupont"
  expect(page).to have_content "12 juin 2015"
end