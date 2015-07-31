require 'rails_helper'
require 'factory_girl'


describe "edit profile" do

	
	it "logs out the user and send them to the root page" do
		 @user = FactoryGirl.create(:user, email: "daniel@yahoo.com", password: "password")
	     visit 'login'
		 fill_in "email", with: "daniel@yahoo.com"
       	 fill_in "Password", with: "password"
		 click_button "Log in"
		 click_on 'Account'
		 	     puts @user
	     click_on 'Edit'
	     expect(page).to have_content("Update your profile")
	end	

end