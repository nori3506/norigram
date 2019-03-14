class PagesController < ApplicationController
  before_action :login_check
  
  def home 
    @picture  = current_user.pictures.build
    @feed_items = current_user.feed.paginate(page: params[:page])
    @comment = Comment.new 
    @pic = Picture.find_by(params[:id])
  end
end