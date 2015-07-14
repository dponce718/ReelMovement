class UsersController < ApplicationController
  


	def index


	end

	def show 
		@user = User.find(params[:id])
		
    	
	end

	def new 

		@user = User.new

	end

	def edit 


	end

	def create 
		  	@user = User.new(user_params)
		 	if @user.save
		 		flash[:success] = "Welcome to the Sample App!"
      		 redirect_to @user
			else
     		render 'new'
   			end
	end

	def update 


	end

	def destroy 


	end 


	private

	# Use strong_parameters for attribute whitelisting
	# Be sure to update your create() and update() controller methods.

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
	end

end