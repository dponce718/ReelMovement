require 'rails_helper'
require 'factory_girl'

	describe "signing up" do
		it "allows user to sign up to reel movement and creates an object in the database" do
			expect(User.count).to eq(0) 

			visit "/"
			expect(page).to have_content "Join Now"
			click_link "Join Now"

			fill_in "Name", with: "daniel"
			fill_in "Email", with: "danielcoolness@yahoo.com"
			fill_in "Password", with: "batman1234"
			fill_in "Password confirmation", with: "batman1234"
			click_button "Sign up"

			expect(User.count).to eq(1) 
			expect(page).to have_content "Welcome! You have signed up successfully "

		end	
	end		