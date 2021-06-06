class Admin::UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update]

  def index
    @users = User.all.includes(:tasks).page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_root_path, notice: t('.notice')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_root_path, notice: t('.notice')
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname, :admin)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
