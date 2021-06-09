class Admin::UsersController < ApplicationController
  before_action :find_user, except: [:index, :new, :create]
  before_action :admin_verify

  def index
    @users = User.all.includes(:tasks).order(id: :asc).page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def show
    @tasks = @user.tasks.all.includes(:user).page(params[:page]).per(5)
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

  def destroy
    if @user.destroy
      redirect_to admin_root_path, notice: t('.notice')
    else
      redirect_to admin_root_path, alert: @user.errors.full_messages.to_sentence
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname, :admin)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def admin_verify
    if current_user.admin      
    else
      redirect_to root_path, notice: t('admin.users.admin_verify.notice')
    end
  end
end
