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


  describe "POST 'create'" do
  		context "with correct credentials" do
	
		@user = {:name =>"daniel", :email => "danielcoolness@yahoo.com", :password => "rowland1", :password_confirmation => "rowland1"}
        
    		it "redirects to the user path" do

    		@user = {:name =>"daniel", :email => "danielcoolness@yahoo.com", :password => "rowland1", :password_confirmation => "rowland1"}
    		@user_created = User.create!(@user)
    		
    		post :create, {email: "danielcoolness@yahoo.com", session: {  password: "rowland1" }}
    		expect(response).to be_redirect
    		expect(response).to redirect_to('/users/'+@user_created.id.to_s)
		end


		it "finds the user" do
			User.expects(:find_by).with({email: "danielcoolness@yahoo.com"}).returns(@user)
			
			post :create, {email: "danielcoolness@yahoo.com", session: {  password: "rowland1" }}
		end	


		it "authenticates the user" do

			@user = {:name =>"daniel", :email => "danielcoolness@yahoo.com", :password => "rowland1", :password_confirmation => "rowland1"}   	
    		@user_created = User.create!(@user)
    	
			User.stubs(:find_by).returns(@user)
			@user.expects(:authenticate).once
			post :create,  session: { email: "danielcoolness@yahoo.com", password: "rowland1" }
	 	end

	 	it "sets the user_id in the session" do
	 		
	 		@user = {:name =>"daniel", :email => "danielcoolness@yahoo.com", :password => "rowland1", :password_confirmation => "rowland1"}
    		@user_created = User.create!(@user)

	 		 post :create,  {email: "danielcoolness@yahoo.com", session: {  password: "rowland1" }}
	 		expect(session[:user_id]).to eq(@user_created.id)
	 	end
	  end  


	  	it "sets the flash success message" do
	  	@user = {:name =>"daniel", :email => "danielcoolness@yahoo.com", :password => "rowland1", :password_confirmation => "rowland1"}
    	@user_created = User.create!(@user)
        post :create,  {email: "danielcoolness@yahoo.com", session: {  password: "rowland1" }}
        expect(flash[:success]).to eq("Thanks for logging in!")
      end


	  	shared_examples_for "denied login" do

	  		it "renders new template" do
	  			post :create, session: {email: email, password: password}
	  			expect(response).to render_template('new')
	  	end	

	  	it "sets the flash danger message" do
	  		post :create, session: {email:"incorrect@yahoo.com", password: "wrongpass"}
	  		expect(flash[:danger]).to eq("there was a problem logging in. Please check your email and password.")
	  	end
	  end			

	  	context "with blank credentials" do
	  		let(:email) {""}
	  		let(:password) {""}
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
