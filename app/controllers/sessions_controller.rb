class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_session] = @user.id
      redirect_to root_path, notice: t('.notice')
    else
      redirect_to sign_in_users_path, notice: t('.fail')
    end
  end

  def destroy
    session[:user_session] = nil
    redirect_to sign_in_users_path, notice: t('.notice')
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
