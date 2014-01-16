class CommentsController < ApplicationController
  before_action :signed_in_user

  def create
  	@comment = Comment.create!(comment_params)
    redirect_to entry_path comment_params[:entry_id] 
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :entry_id)
  end
end