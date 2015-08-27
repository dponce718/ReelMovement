FactoryGirl.define do
  factory :user do
    	name "Jacqueline"
   			sequence :email do |n| 
      			"user#{n}@example.com"
    		end
     	
			password "password"
			password_confirmation "password" 
  end    

	factory :user_daniel do
    name "Daniel"
		email "danielcoolness@yahoo.com"
    password "rowland1"
    password_confirmation "rowland1"   
  end	

  factory :user_log_in do
        email { Faker::Internet.email }
        password { Devise.friendly_token.first(8) }
  end      
end