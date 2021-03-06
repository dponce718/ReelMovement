class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :my, :types
  include AuthenticationHelper
  include PasswordResetsHelper

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  
  def after_sign_in_path_for(resource)
      if resource.respond_to? :profil  

      if current_user.profil.nil?        
          new_user_profil_url(current_user) 
      else                               
         user_path                         
      end                                
        else                                 
         super                              
      end                                  
    end                      
end
