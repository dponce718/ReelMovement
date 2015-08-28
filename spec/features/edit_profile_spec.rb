require 'rails_helper'
require 'factory_girl'


describe "edit profile" do

	
	it "logs out the user and send them to the root page" do
		 @user = FactoryGirl.create(:user, email: "daniel@yahoo.com", password: "password")
	     visit '/'
	     click_on 'Log in'
		 fill_in "Email", with: "daniel@yahoo.com"
       	 fill_in "Password", with: "password"
		 click_button "Log in"
		 click_on 'Account'
	     click_on 'Edit registration'
	     expect(page).to have_content("Edit User")
	end	

	it " unsuccessful edit password to short" do
		 @user = FactoryGirl.create(:user, email: "daniel@yahoo.com", password: "password")
	     visit '/'
	     click_on 'Log in'
		 fill_in "Email", with: "daniel@yahoo.com"
       	 fill_in "Password", with: "password"
		 click_button "Log in"
		 click_on 'Account'
	     click_on 'Edit'
	     click_button 'Update'
	     expect(page).to have_content("Password is too short")
	 end    

	 it "successful edit" do
	 	@user = FactoryGirl.create(:user, email: "daniel@yahoo.com", password: "password")
	     visit '/'
	     click_on 'Log in'
		 fill_in "Email", with: "daniel@yahoo.com"
       	 fill_in "Password", with: "password"
		 click_button "Log in"
		 click_on 'Account'
	     click_on 'Edit registration'
	     fill_in "Email", with: "daniel@yahoo.com"
	     fill_in "Password", with: "password1234"
	     fill_in "Password confirmation", with: "password1234"
	     fill_in "Current password", with: "password"
	     click_button 'Update'	
	     expect(page).to have_content("Your account has been updated successfully")
	  end	

	  it "requires user to be logged in " do
	  	@user = FactoryGirl.create(:user, email: "daniel@yahoo.com", password: "password")
	  	visit 'edit_profile'
	  	expect(page).to have_content("Please log in")
	  end	


end