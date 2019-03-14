class CommentsController < ApplicationController
  before_action :login_check
  before_action :correct_user, only: :destroy

  def create
    @picture = Picture.find_by(id:params[:comment][:picture_id])
    @comment = @picture.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      flash[:danger]="投稿に失敗しました。"
      render 'pictures/show'
    end
  end
  
  def destroy
    @comment.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

private
  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      flash[:danger]="自分のコメント以外は削除することができません"
      redirect_to root_url if @comment.nil?
  end

end