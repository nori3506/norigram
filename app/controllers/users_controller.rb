class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end
  
  def create
    @user=User.new(user_params)
    if @user.term === true && @user.save
      log_in(@user)
      flash[:success] = "New User was crated! Welcome to NoriGram"
      redirect_to @user
    elsif @user.term === false
      flash[:danger]= "利用規約に同意が必要です"
      render 'new'
    else
      flash[:danger] = "Failed! Please make sure you filled all fields"
      render 'new'
    end
  end
  
  def new
    redirect_to pages_home_path if loggedin?
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
    @pictures = @user.pictures
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
    @user.comments.delete_all
    @user.pictures.delete_all
    if @user.delete
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Follower"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def term
  end
  
private

  def user_params
    params.require(:user).permit(:email, :fullname, :username, :password,:website, :introduction, :tel, :gender, :image, :term)
  end
  
  def logged_in_user
    unless loggedin?
      store_location
      flash[:danger] = "Please log in."
      redirect_to new_session_url
    end
  end
end