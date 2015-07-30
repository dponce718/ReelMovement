module SessionsHelper
	# Logs in the given user.
  def log_in(user)
    session[:user_id] = @user.id
  end 

  def current_user
    User.find_by(id: session[:user_id])
    if @current_user.nil?
      @current_user = @current_user || User.find_by(id: session[:user_id])
    else
      @current_user
    end
  end

  def logged_in?
    !current_user.nil?
  end  


  def log_out
    session.delete(:user_id)
      @current_user = nil
  end  

  def require_user
    if current_user
        true
    else
      redirect_to signup_path, notice: "you must be logged in to access that page"     
     end 
  end  



end

