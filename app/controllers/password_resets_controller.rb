class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
   before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end



  def create
  	@user = User.find_by(email: params[:password_reset][:email].downcase)
  	if @user
  	   @user.create_reset_digest
  	   @user.send_password_reset_email
  	   flash[:info] = "Email sent with password reset instructions"
  	   redirect_to root_url
  	 else
  	 flash.now[:danger] = "Email address not found"  
  	 render 'new'
  	end	   
  end

     def edit

    end


     def update
    if params[:user][:password].empty?
      flash.now[:danger] = "Password can't be empty"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end

  end

    private

    def user_params
    params.require(:user).permit(:password_confirmation)
 end

    def get_user
      @user = User.find_by(email: params[:email])
      unless (@user && @user.activated? && 
              @user.authenticated?(:reset, params[:id])) 
           redirect_to root_url
           end    
    end  

     # Before filters

    # Confirms a valid user.
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end



    # Checks expiration of reset token.
    def check_expiration
      if  reset_sent_at < 2.hours.ago
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end

