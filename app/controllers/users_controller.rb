class UsersController < ApplicationController
  # before_action :login_check, except:[:new]
  before_action :logged_in_user, only: [:edit, :update, :destroy,
                                        :following, :followers]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
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
    @title = "フォローしているユーザー"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
private

  def user_params
    params.require(:user).permit(:email, :fullname, :username, :password,:website, :introduction, :tel, :gender, :image)
  end
  
  def logged_in_user
      unless loggedin?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
  end
  
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end
  
  
end