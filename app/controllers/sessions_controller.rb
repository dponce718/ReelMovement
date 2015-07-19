class SessionsController < ApplicationController
  
  	def new
  	end


  
  	def create
      user = User.find_by(email:params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:notice] = "Welcome back!"
  		  redirect_to users_path
      else
        render action: 'new'
      end    
	  end	

  	
    def destroy
  	end

end
