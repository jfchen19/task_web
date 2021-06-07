class TasksController < ApplicationController
  before_action :find_task, except: [:index, :new, :create]

  def index
    if current_user.present?
      task_index
    else
      redirect_to sign_in_users_path, notice: t('.notice')
    end
  end
  
  def new
    # byebug
    @task = Task.new
  end

  def show
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to '/', notice: t('.notice')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to '/', notice: t('.notice')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy if @task
    redirect_to '/', notice: t('.notice')
  end

  def start
    @task.start! if @task.may_start?
    redirect_to '/'
  end

  def complete
    @task.complete! if @task.may_complete?
    redirect_to '/'
  end

  private
  def find_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:title, :subject, :start_time, :end_time, :priority, :tag_list)
  end

  def task_index
    @tasks = current_user.tasks.includes(:user).sort_tasks(params).search_task(params[:keyword]).where("state LIKE ?", "%#{params[:search_by_state]}%").page(params[:page]).per(5)
  end
end
