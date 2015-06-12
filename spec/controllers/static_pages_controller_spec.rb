require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #Home" do
    it "returns http success" do
      get :Home
      expect(response).to have_http_status(:success)
    end
  end

end
