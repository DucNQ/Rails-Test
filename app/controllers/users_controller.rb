class UsersController < ApplicationController
  before_action :signed_in_user,    only: [:index, :destroy]
  before_action :already_signed_in, only: [:new]
  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end
  def show
  	@user = User.find(params[:id])
    @entries = @user.entries.paginate(page: params[:page])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the our Blog Website!"
			redirect_to @user
    else
      render 'new'
    end
  end

  private

  def already_signed_in
    if signed_in?
      redirect_to user_path(@current_user)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
