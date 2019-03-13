class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  def login_check
    if !loggedin?
    flash[:danger] ="please login"
    redirect_to root_path
    end
  end
  
  def require_same_user
    if current_user != @user
      flash[:danger] = "You can only edit or delete your own account"
      redirect_to root_path
    end
  end
  
end
