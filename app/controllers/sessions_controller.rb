class SessionsController < ApplicationController
  
  	def new
  	end


  
  	def create
      @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:session][:password])
         log_in @user
          flash[:success] = "Thanks for logging in!"
            redirect_to @user
        else
          flash.now[:danger] = "there was a problem logging in. Please check your email and password."
          render 'new'
        end    
	  end	

  	
    def destroy
  	end

end


