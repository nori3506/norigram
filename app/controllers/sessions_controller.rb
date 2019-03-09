class SessionsController < ApplicationController
  before_action :space_check, only:[:create]
  
  def new
    
  end
  
  def create
    parameter = params[:session][:username]
    user = User.find_by(username: parameter)
    user1 = User.find_by(email: parameter)
    user2 = User.find_by(tel: parameter)
    if (user && user.authenticate(params[:session][:password])) || (user1 && user1.authenticate(params[:session][:password])) || (user2 && user2.authenticate(params[:session][:password]))
      if !user1.nil?
        log_in user1
      end  
      if !user.nil?
        log_in user
      end
      if !user2.nil?
        log_in user2
      end
      current_user
      flash[:success] = "Log In Successfully!"
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out successfully"
    redirect_to root_path
  end
  
private
  def username_user?(params)
    user = params
    user.nil?
  end
  
  def space_check
    if params[:session][:username].blank?
      flash[:danger] = "ユーザーネームかEmailアドレスか電話番号を入力してください"
      render 'new'
    end
  end
  
end