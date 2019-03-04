class UsersController < ApplicationController
  
  before_action :loggedin?, only:[:edit, :create, :update, :destroy]
  
  def index
  end
  
  def create
    @user=User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "New User was crated! Welcome to NoriGram"
      redirect_to @user
    else
      flash[:danger] = "Failed!"
      render 'new'
    end
  end
  
  def new
    redirect_to user_path(@current_user) if loggedin?
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])

  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to @user
    else
    render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.delete
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
private

  def user_params
    params.require(:user).permit(:email, :fullname, :username, :password,:website, :introduction, :tel, :gender)
  end
end