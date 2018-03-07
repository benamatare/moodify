module ApplicationHelper

  def login?
    if session[:user_id]
      true
    else
      false
    end
  end

  def logged_in_user
    if session[:user_id]
      @logged_in_user = User.find(session[:user_id])
    else
      @logged_in_user = User.create
      session[:user_id] = @logged_in_user.id
    end
  end

end
