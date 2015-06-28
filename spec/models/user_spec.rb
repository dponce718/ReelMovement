require 'rails_helper'

RSpec.describe User, type: :model do
	 let(:valid_attributes) {
    {
      name: "Jacqueline",
      email: "jboltik@oolaabox.com",
      password: "password",
      password_confirmation: "password"
    }
  }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_length_of(:email).is_at_most(250)}
  it { should_not allow_value('user@example,com').for(:email) }
  it { should_not allow_value('user_at_foo.org').for(:email) }
  it { should_not allow_value('foo@bar_baz.com').for(:email) }
  it { should_not allow_value('foo@bar+baz.com').for(:email) }
  it { should have_secure_password }

  it "downcases an email before saving" do
      user = User.new(valid_attributes)
      user.email = "JBOLTIK@OOLAABOX.COM"
      expect(user.save).to be true
      expect(user.email).to eq("jboltik@oolaabox.com")
    end
  end


