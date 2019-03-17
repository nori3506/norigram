class PagesController < ApplicationController
  before_action :login_check
  
  def home 
    @feed_items = current_user.feed.paginate(page: params[:page])
    @comment = Comment.new 
  end
end