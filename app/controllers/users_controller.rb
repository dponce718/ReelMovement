class UsersController < ApplicationController
  


	def show 
		@user = User.find(params[:id])	
	end

	def new 
		@user = User.new
	end


	def create 
		@user = User.new(user_params)
    		if  @user.save && @user.authenticate(user_params[:password])
    		log_in @user
   	  	    redirect_to @user, :flash => { :success => "Welcome to the Sample App!" }
  		    else
      		@title = "Sign up"
      		render 'new'
    		end
  	end

  	def edit
    	@user = User.find(session[:user_id])
  	end

  	def update
  		@user = User.find_by_id(params[:id])
     if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

	

	private

	# Use strong_parameters for attribute whitelisting
	# Be sure to update your create() and update() controller methods.

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end

end

