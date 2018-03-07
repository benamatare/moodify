class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper ApplicationHelper


  def home
    if helpers.login?
      redirect_to "/users/#{session[:user_id]}"
    end
  end


end
