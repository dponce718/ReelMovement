require 'rails_helper'
require 'factory_girl'


RSpec.describe User, type: :model do
	 
  before do
    @user = FactoryGirl.create(:user)
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_length_of(:email).is_at_most(250)}
  it { should_not allow_value('user@example,com').for(:email) }
  it { should_not allow_value('user_at_foo.org').for(:email) }
  it { should_not allow_value('foo@bar_baz.com').for(:email) }
  it { should_not allow_value('foo@bar+baz.com').for(:email) }
  it { should_not allow_value('foo@bar+baz..com').for(:email) }
  it { should have_secure_password }


  describe "email uniqueness" do
  it { should validate_uniqueness_of(:email) }
  end

  describe "downcase_email" do  
    it "makes the email attribute lower case" do
      @user = FactoryGirl.create(:user)
      @user.email = "JBOLTIK@OOLAABOX.COM"
      @user.email.downcase!
      expect(@user.email).to eq("jboltik@oolaabox.com")
    end
    
    it "downcases an email before saving" do
      @user = FactoryGirl.create(:user)
      @user.email = "JBOLTIK@OOLAABOX.COM"
      expect(@user.save).to eq true
      expect(@user.email).to eq("jboltik@oolaabox.com")
    end
  end
 end



