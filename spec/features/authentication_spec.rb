require 'rails_helper'
require 'factory_girl'


describe "logging in and logging out" do

	it "logs the user in and goes to his/her profile page" do
		     @user = FactoryGirl.create(:user, email:  "danielcoolness@yahoo.com", password: "rowland1", password_confirmation: "rowland1")
		      visit 'login'
		      fill_in "email", with: "danielcoolness@yahoo.com"
			  fill_in "password", with: "rowland1"
			  click_button "Log in"

			  expect(page).to have_content("Welcome back")
	end 


	it "displays the email address in the event of a failed log in" do
		visit 'login'
		fill_in "email", with: "daniel@yahoo.com"
		fill_in "password", with: "incorrect"
		click_button "Log in"

		expect(page).to have_content("Invalid email/password combination")
		expect(page).to have_field("email", with: "daniel@yahoo.com")
	end	

	it "logs out the user and send them to the root page" do
		 @user = FactoryGirl.create(:user, email: "daniel@yahoo.com", password: "password")
	     visit 'login'
		 fill_in "email", with: "daniel@yahoo.com"
       	 fill_in "password", with: "password"
		 click_button "Log in"
		 click_on 'Account'
	     click_on 'Log out'
	     expect(page).to have_content("Join Now")
	end	

end