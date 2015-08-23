module AuthenticationHelper

	#for controller
	#def sign_in(user) 
	#	controller.stub(:current_user).and_return(user)
	#	controller.stub(:user_id).and_return(user.id)
	#end

	#for authentication spec
	def feature_sign_in(user, options={})
		visit '/login'
		fill_in 'email', with: user.email
		fill_in 'password', with: options[:password]
		click_button "Log in"
	end	
end