class EntriesController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]
  before_action :correct_user, only: :destroy

  def new
  	@entry = Entry.new
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
	    flash[:success] = "New entry posted!"
	    redirect_to root_url
	  else
	    render 'new'
	  end
  end

  def show
  	@entry = Entry.find_by(params[:id])
    @comments = @entry.comments
    @comment = Comment.new
  end

  def destroy
  	@entry.destroy
  	redirect_to root_url
  end

  def comment 
    render root_url
  end
  private
  def entry_params
    params.require(:entry).permit(:title, :body)
  end

  def correct_user
	@entry = current_user.entries.find_by(id: params[:id])
	redirect_to root_url if @entry.nil?
  end
end
