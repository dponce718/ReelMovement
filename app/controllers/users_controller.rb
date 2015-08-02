class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
   before_action :admin_user,     only: [:index, :destroy]


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






#def create 
 #   @user = User.new(user_params)
  #      if  @user.save && @user.authenticate(user_params[:password])
     #     @user.send_activation_email
     # flash[:info] = "Please check your email to activate your account."
      #  log_in @user
       #     redirect_to @user, :flash => { :success => "Welcome to the Sample App!" }
        ##  else
          #@title = "Sign up"
         # render 'new'
        #end
    #end

