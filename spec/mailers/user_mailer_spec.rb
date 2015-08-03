require "rails_helper"


RSpec.describe UserMailer, :type => :mailer do
  describe "account_activation" do

    let(:user)  {FactoryGirl.create(:user)}

  
    it "renders the headers" do
      mail = UserMailer.account_activation(user)
      user.activation_token = User.new_token
      expect(mail.subject).to eq("Account activation")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["reelmovementllc@gmail.com"])
    end

    it "renders the body" do
      mail = UserMailer.account_activation(user)
      user.activation_token = User.new_token
      expect(mail.body.encoded).to match(user.activation_token)
      expect(mail.body.encoded).to match(user.name)
      expect(mail.body.encoded).to match(CGI::escape(user.email))
    end
  end

  describe "password_reset" do
     let(:user)  {FactoryGirl.create(:user)}

    it "renders the headers" do
      mail = UserMailer.password_reset(user)
      user.reset_token = User.new_token
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["reelmovementllc@gmail.com"])
    end

    it "renders the body" do
      mail = UserMailer.password_reset(user)
      user.reset_token = User.new_token
      expect(mail.body.encoded).to match(CGI::escape(user.email))
    end
  end
end
