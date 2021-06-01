class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_parmas)

    if @user.save
      redirect_to root_path, notice: "註冊成功"
    else
      render :new, notice: "註冊失敗"
    end
  end

  private
  def user_parmas
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname)
  end
end
