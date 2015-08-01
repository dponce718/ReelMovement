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
	     click_on 'Edit'
	     expect(page).to have_content("Update your profile")
	end	

	it " unsuccessful edit password to short" do
		 @user = FactoryGirl.create(:user, email: "daniel@yahoo.com", password: "password")
	     visit 'login'
		 fill_in "email", with: "daniel@yahoo.com"
       	 fill_in "Password", with: "password"
		 click_button "Log in"
		 click_on 'Account'
	     click_on 'Edit'
	     click_button 'Save changes'
	     expect(page).to have_content("Password is too short")
	 end    

	 it "successful edit" do
	 	@user = FactoryGirl.create(:user, email: "daniel@yahoo.com", password: "password")
	     visit 'login'
		 fill_in "email", with: "daniel@yahoo.com"
       	 fill_in "Password", with: "password"
		 click_button "Log in"
		 click_on 'Account'
	     click_on 'Edit'
	     fill_in "Name", with: "daniel"
	     fill_in "Email", with: "daniel@yahoo.com"
	     fill_in "Password", with: "password1234"
	     fill_in "Confirmation", with: "password1234"
	     click_button 'Save changes'	
	     expect(page).to have_content("Profile updated")
	    @user.reload
	     expect(@user.password).to eq ("password1234")

	  end	

	  it "requires user to be logged in " do
	  	@user = FactoryGirl.create(:user, email: "daniel@yahoo.com", password: "password")
	  	visit 'edit_profile'
	  	expect(page).to have_content("Please log in")
	  end	


end