class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if User.login(params[:user])
      session[:user_session] = params[:user][:email]
      redirect_to root_path, notice: t('.notice')
    else
      redirect_to session_path, notice: t('.fail')
    end
  end

  def destroy
    session[:user_session] = nil
    redirect_to session_path, notice: t('.notice')
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
