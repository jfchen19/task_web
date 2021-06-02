class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if User.login(params[:user])
      session[:user_session] = params[:user][:email]
      redirect_to root_path, notice: '登入成功'
    else
      redirect_to session_path, notice: '帳號或密碼有誤，請重新輸入'
    end
  end

  def destroy
    session[:user_session] = nil
    redirect_to root_path, notice: '登出成功'
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
