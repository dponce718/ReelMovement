class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
 

  def index  
    @user = User.all
  end

	def show 
		@user = User.find(params[:id])	
	end

	def new 
		@user = User.new
	end

def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end


  	def edit
    	@user = User.find(session[:user_id])
  	end

  	def update
     # puts params
     # binding.pry
  		  @user = User.find_by_id(params[:id])
        if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
        else
        render 'edit'
        end
    end


    def destroy
       User.find(params[:id]).destroy
       flash[:success] = "User deleted"
       redirect_to users_url
    end
  #before filte 

#confirms a logged in user
    def logged_in_user
      unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
      end
    end  

    def correct_user
      @user = User.find(session[:user_id])
      redirect_to(root_url) unless @user == current_user
      end
    end  

  # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
      end
   

	

	private

	# Use strong_parameters for attribute whitelisting
	# Be sure to update your create() and update() controller methods.

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
 end





