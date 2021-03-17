class TasksController < ApplicationController
  before_action :find_task, except: [:index, :create]

  def index
    @tasks = Task.with_created_at(params[:order]).with_end_time(params[:order_by_end_time])
    @task = Task.new
  end

  def show
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to '/', notice: t('.notice')
    else
      @tasks = Task.all
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

  private
  def find_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:title, :subject, :start_time, :end_time)
  end
end
