When(/^I complete meeting's form with the required fields$/) do
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