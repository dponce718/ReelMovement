require 'rails_helper'

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
	
		let!(:user) {User.create(name: "daniel", email: "danielcoolness@yahoo.com", password: "rowland1", password_confirmation: "rowland1")}

    	it "redirects to the user path" do
    		post :create, email: "danielcoolness@yahoo.com", password: "rowland1"
    		expect(response).to be_redirect
    		expect(response).to redirect_to(users_path)
		end

		it "finds the user" do
			User.expects(:find_by).with({email: "danielcoolness@yahoo.com"}).returns(user)
			post :create, email: "danielcoolness@yahoo.com", password: "rowland1"
		end	

		it "authenticates the user" do
			User.stubs(:find_by).returns(user)
			user.expects(:authenticate).once
			post :create, email: "danielcoolness@yahoo.com", password: "rowland1"
	 	end

	 	it "sets the user_id in the session" do
	 		post :create, email: "danielcoolness@yahoo.com", password: "rowland1"
	 		expect(session[:user_id]).to eq(user.id)
	 	end
	  end  

	  	it "sets the flash welcome message" do
	  		post :create, email: "danielcoolness@yahoo.com", password: "rowland1"
	  		expect(flash[:notice]).to eq("Welcome back!")
	  	end

	  	context "with blank credentials" do
	  		it "renders the new template" do
	  		post :create
	  		expect(response).to render_template('new')
	  	end	
	  end
   	end
end
