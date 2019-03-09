class CommentsController < ApplicationController
  before_action :login_check

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
  end

private
  def comment_params
    params.require(:comment).permit(:content)
  end

end