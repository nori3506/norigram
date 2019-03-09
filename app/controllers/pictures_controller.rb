class PicturesController < ApplicationController
  before_action :login_check

  
  def new
    @picture = Picture.new
  end
  
  def create 
    
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      flash[:success]="New picture was uploaded successfully!"
      redirect_to @picture
    end
  end
  
  def show
    @picture = Picture.find(params[:id])
    @comment = Comment.new
    
    
  end
  
  def destroy
  end
  
private 
  def picture_params
    params.require(:picture).permit(:name)
  end
  
end