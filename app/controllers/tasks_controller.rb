class TasksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    unless current_user.nil?
      @tasks = current_user.tasks.where.not(status: 3).order(:updated_at)

      @completed_tasks = current_user.tasks.where(status: 3).order(updated_at: :desc)
    end
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = current_user.tasks.create task_params
    if @task.save
      redirect_to root_path
    else
      render plain: @task.errors.full_messages
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update task_params
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path
  end

  def complete
    @task = Task.find(params[:id])

    @task.complete!

    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end
end
