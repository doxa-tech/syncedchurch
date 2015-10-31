When(/^I visit the member edit path$/) do
  @member = create(:member)
  visit edit_member_path(@member)
end

When(/^I change the firstname of the member$/) do
  save_and_open_page
  fill_in "Prénom", with: "George"
  click_button "Enregistrer"
end

Then(/^I should see the updated firstname$/) do
  expect(page).to have_field "Prénom", with: "George"
end
