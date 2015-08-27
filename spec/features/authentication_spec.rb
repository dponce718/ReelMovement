require 'rails_helper'
require 'factory_girl'


describe "logging in and logging out" do

	before do
		 User.create!(name: "daniel", email:"danielcoolness@yahoo.com", password: "rowland1")
		end

	it "logs the user in and goes to his/her profile page" do
			
			  visit '/'	
		      click_link 'Log in'
		      fill_in "Email", with: "danielcoolness@yahoo.com"
			  fill_in "Password", with: "rowland1"
			  click_button "Log in"
			  expect(page).to have_content("Signed in successful")
	end 


	it "displays the email address in the event of a failed log in" do
		
		visit '/'
		click_link 'Log in'
		fill_in "Email", with: "danielcoolness@yahoo.com"
		fill_in "Password", with: "incorrect"
		click_button "Log in"

		expect(page).to have_content("Invalid email or password")
		expect(page).to have_field("email", with: "danielcoolness@yahoo.com")
	end	

	it "logs out the user and send them to the root page" do
		 
	     visit '/'
	     click_link 'Log in'
		 fill_in "Email", with: "danielcoolness@yahoo.com"
       	 fill_in "Password", with: "rowland1"
		 click_button "Log in"
		 click_on 'Account'
	     click_on 'Log out'
	     expect(page).to have_content("Join Now")
	end	

end