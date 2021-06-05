class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_parmas)

    if @user.save
      redirect_to session_path, notice: t('.notice')
    else
      render :new
    end
  end

  private
  def user_parmas
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname)
  end
end
