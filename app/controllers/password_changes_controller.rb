class PasswordChangesController < UsersController
  before_action :login_check, only:[:edit,:update]
  before_action :require_same_user, only: [:edit, :update]
  before_action :present_password_check, only:[:update]
  

  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    if @user.update(password_params)
      flash[:success] ="Your password was changed successfully"
      redirect_to @user
    else
      render 'edit'
    end
  
  end
  
private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  
  def present_password_check
    @user =User.find_by(id: params[:id])
    if !@user.authenticate(params[:user][:present_password])
      flash[:danger]="現在のパスワードが間違っています。"
      render 'edit'
    end
  end
end