class UsersController < ApplicationController


  def login

  end

  def post_login
    @user = User.find_by_username(params[:user][:username])
    if @user.authenticate(params[:user][:password])
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
      redirect_to :login
    else
      @user = User.new(new_user_params)
      if @user.valid?
        @user.save
        session[:user_id] = @user.id
        render :show
      end
    end
  end

  def show
  end



private

  def new_user_params
    params.require(:user).permit(:username,:first_name,:last_name, :email, :password, :password_confirmation)
  end
end
