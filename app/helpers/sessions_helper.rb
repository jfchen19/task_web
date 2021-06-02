module SessionsHelper
  def current_user
    User.find_by(email: session[:user_session])
  end
end
