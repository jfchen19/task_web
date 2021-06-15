class TasksController < ApplicationController
  before_action :find_task, except: [:index, :new, :create]

  def index
    if current_user.present?
      @tasks = current_user.tasks.includes(:user, :tags)
                           .sort_tasks(params)
                           .search_task(params[:keyword])
                           .search_by_tag(params[:tag])
                           .search_by_state(params[:state])
                           .page(params[:page]).per(5)
    else
      redirect_to sign_in_users_path, notice: t('.notice')
    end
  end
  
  def new
    @task = Task.new
  end

  def show
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to root_path, notice: t('.notice')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: t('.notice')
    else
      render :edit
    end
  end

  def update_state
    @task.update(state: params[:state])
    redirect_to root_path
  end

  def destroy
    @task.destroy if @task
    redirect_to root_path, notice: t('.notice')
  end

  private
  def find_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:title, :subject, :start_time, :end_time, :priority, :tag_list)
  end
end
