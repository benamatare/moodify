class UsersController < ApplicationController
  before_action :call_login?, only: [:show]
  before_action :user_login?, only: [:edit]

  def login
  end

  def post_login
    @user = User.find_by_username(params[:user][:username])
    if @user == nil
      render :login
    elsif @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :login
    end
  end

  def signup
    @user = User.new
  end

  def create
    if params[:user][:password] != params[:user][:password_confirmation]
      render :signup
    else
      @user = User.new(new_user_params)
      if @user.valid?
        @user.save
        session[:user_id] = @user.id
        redirect_to @user
      else
        render :signup
      end
    end
  end

  def show #/users/1
    @user = User.find(params[:id])
    if session[:user_id] == @user.id
      @playlist = Playlist.new
      @owner_homepage  = true
    else
      @owner_homepage = false
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/'
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    @user.update(update_user_params)
    if @user.valid?
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil
    redirect_to '/'
  end


private

  def update_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation )
  end

  def new_user_params
    params.require(:user).permit(:username,:first_name,:last_name, :email, :password, :password_confirmation)
  end

  def call_login?
    if helpers.login? == false
      redirect_to '/'
    end
  end

  def user_login?
    @user = User.find(params[:id])
    if session[:user_id] != @user.id
      redirect_to user_path(@user)
    end
  end
end
