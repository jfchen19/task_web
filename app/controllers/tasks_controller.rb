class TasksController < ApplicationController
  before_action :find_task, except: [:index, :create]

  def index
    if current_user.present?
      task_index 
      @task = Task.new
    else
      redirect_to session_path, notice: '請先登入'
    end
  end

  def show
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to '/', notice: t('.notice')
    else
      task_index
      render :index
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
    params.require(:task).permit(:title, :subject, :start_time, :end_time, :priority)
  end

  def task_index
    @tasks = Task.sort_tasks(params).search_task(params[:keyword]).where("state LIKE ?", "%#{params[:search_by_state]}%").page(params[:page]).per(5)
  end
end
