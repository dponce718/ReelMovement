require 'rails_helper'
require 'sessions_helper'



RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
    	get 'new'
    	expect(response).to render_template('new')
  	end
  end

		before do
  				@user = FactoryGirl.create(:user_daniel)
  			end	

  describe "POST 'create'" do
  		context "with correct credentials" do

	
    		it "redirects to the user path" do

    		
    		post :create, {email: "danielcoolness@yahoo.com", session: {  password: "rowland1" }}
    		expect(response).to be_redirect
    		expect(response).to redirect_to(@user)
		end


		it "finds the user" do
			User.expects(:find_by).with({email: "danielcoolness@yahoo.com"}).returns(@user)
			
			post :create, {email: "danielcoolness@yahoo.com", session: {  password: "rowland1" }}
		end	


		it "authenticates the user" do

			
			User.stubs(:find_by).returns(@user)
			@user.expects(:authenticate).once
			post :create,  session: { email: "danielcoolness@yahoo.com", password: "rowland1" }
	 	end

	 	it "sets the user_id in the session" do
	 		

	 		 post :create,  {email: "danielcoolness@yahoo.com", session: {  password: "rowland1" }}
	 		expect(session[:user_id]).to eq(@user.id)
	 	end
	  end  


	  	it "sets the flash success message" do
	  	
        post :create,  {email: "danielcoolness@yahoo.com", session: {  password: "rowland1" }}
        expect(flash[:success]).to eq("Thanks for logging in!")
      end


	  	shared_examples_for "denied login" do

	  		it "renders new template" do
	  			post :create, session: {email: "email", password: "password"}
	  			expect(response).to render_template('new')
	  	end	

	  	it "sets the flash danger message" do
	  		post :create, session: {email:"incorrect@yahoo.com", password: "wrongpass"}
	  		expect(flash[:danger]).to eq("there was a problem logging in. Please check your email and password.")
	  	end
	  end			

	  	context "with blank credentials" do

  			@user = FactoryGirl.attributes_for(:user_daniel, email: "", password: "")
	  		it_behaves_like "denied login"
	  	end	

	  	context "with an incorrect password" do
	  		let!(:user) {User.create(name: "daniel", email: "danielcoolness@yahoo.com", password: "rowland1", password_confirmation: "rowland1")}
	  		let(:email) { user.email}
	  		let(:password) {"incorrect"}
	  		it_behaves_like "denied login"
	  end
	  context "with an incorrect email" do
	  		let(:email) { "no@found.com"}
	  		let(:password) {"incorrect"}
	  		it_behaves_like "denied login"
	  end
   	end
end
