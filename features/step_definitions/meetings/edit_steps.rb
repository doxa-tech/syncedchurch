When(/^I visit the meeting edit path$/) do
  @meeting = create(:meeting)
  visit edit_meeting_path(@meeting)
end

When(/^I change the date of the meeting$/) do
  select_date "22 juillet 2015", from: "meeting_date"
  click_button "Enregistrer"
end

Then(/^I should see the meeting's updated date$/) do
  expect(page).to have_select "meeting_date_3i", selected: "22"
  expect(page).to have_select "meeting_date_2i", selected: "juillet"
  expect(page).to have_select "meeting_date_1i", selected: "2015"
end