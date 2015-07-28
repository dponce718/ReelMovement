require 'rails_helper'
require 'factory_girl'

RSpec.describe UsersController, type: :controller do

  let(:valid_attributes) { { 
    "first_name" => "MyString",
    "last_name" => "LastName",
    "email" => "email@example.com",
    "password" => "password12345",
    "password_confirmation" => "password12345"
  } }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  
  let(:valid_session) { {} }

  describe "POST create" do
  it "sets the session user_id to the created user" do
        post :create, {:user => valid_attributes}, valid_session
        expect(session[:user_id]).to eq(User.find_by(email: valid_attributes["email"]))
      end
    end
  end




