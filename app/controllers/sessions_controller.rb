class SessionsController < ApplicationController
  
  	def new
  	end


  
  	def create
      @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:session][:password])
         log_in @user
           params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          flash[:success] = "Thanks for logging in!"
          redirect_to @user
        else
          flash.now[:danger] = "there was a problem logging in. Please check your email and password."
          render 'new'
        end    
	  end	

  	
    def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
