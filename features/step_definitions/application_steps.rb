Given(/^there are members in the church$/) do
  @member = create(:member)
end

Given(/^there is a group$/) do
  @group = create(:group)
end

Given(/^there is an user$/) do
  @user = create(:user)
end

Given(/^I am logged in$/) do
  step "there is an user"
  create_cookie(:remember_token, @user.remember_token)
end

When(/^I logout$/) do
  delete_cookie(:remember_token)
end

When(/^I visit "(.*?)"$/) do |path|
  visit path
end

When(/^I do not complete the form$/) do
  click_button "Créer"
end

When(/^I click the link "(.*?)"$/) do |link|
  click_link link
end

When(/^I click the button "(.*?)"$/) do |text|
  click_button text
end

Then(/^I should see a flash containing "(.*?)"$/) do |message|
  expect(find '#flash').to have_content(message)
end

Then(/^I should see errors for the fields "(.*?)"$/) do |fields|
  fields.split(",").each do |field|
    expect(find '#errors').to have_content field
  end
end

Then(/^I should be visiting "(.*?)"$/) do |path|
  expect(page.current_path).to eq path
end