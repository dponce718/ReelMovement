FactoryGirl.define do
  factory :user do
    	name "Jacqueline"
   			sequence :email do |n| 
      			"user#{n}@example.com"
    		end
     	
			password "password"
			password_confirmation "password" 
      activated 'true'
      activated_at 'Time.zone.now' 

	factory :user_daniel do
    name "Daniel"
		email "danielcoolness@yahoo.com"
    password "rowland1"
    password_confirmation "rowland1"  

	end	
end
end