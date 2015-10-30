When(/^I visit the edit path of a member without an email$/) do
  @member = create(:member, email: nil)
  visit edit_member_path(@member)
end

When(/^I visit edit path of a member who is an user$/) do
  @member = create(:user)
  visit edit_member_path(@member)
end

Then(/^I should see the user's password and username$/) do
  expect(find "#user").to have_content "Mot de passe provisoire"
  expect(find "#user").to have_content @member.email
end