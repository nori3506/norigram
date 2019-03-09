class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  def login_check
    if !loggedin?
    flash[:danger] ="please login"
    redirect_to root_path
    end
    
  end
  
end
