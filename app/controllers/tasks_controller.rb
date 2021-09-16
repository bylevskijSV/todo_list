class TasksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index not_authentificated]

  before_action :set_task, only: %i[show edit update destroy complete]
  before_action :check_user_tasks, only: %i[show edit update destroy]

  def index
     if user_signed_in?
      @tasks = current_user.tasks.where.not(status: 3).order(updated_at: :desc)

      @completed_tasks = current_user.tasks.where(status: 3).order(updated_at: :desc)
     else
       redirect_to not_authentificated_path
     end
  end

  def not_authentificated; end

  def new
    @task = Task.new

    @users = User.where.not(email: current_user.email)
  end

  def show; end

  def create
    @task = assigned_task? ? Task.create(assigned_task_params) : current_user.tasks.create(task_params)

    if @task.errors.empty?
      redirect_to tasks_path
    else
      @users = User.where.not(email: current_user.email)
      render :edit
    end
  end

  def edit
    @users = User.where.not(email: current_user.email)
  end

  def update
    updated_task = assigned_task? ? assigned_task_params : task_params

    if @task.update updated_task
      flash[:notice] = 'Task was updated successfully'
      redirect_to task_path
    else
      @users = User.where.not(email: current_user.email)
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:alert] = 'Task was deleted successfully'
    redirect_to tasks_path
  end

  def complete
    @task.complete!

    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end

  def assigned_task_params
    user_id = params[:task][:parent_id]
    parent_id = current_user.id
    task_params.merge(user_id: user_id, parent_id: parent_id)
  end

  def assigned_task?
    params[:task][:assigned_task].to_i == 1
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def check_user_tasks
    return unless current_user != @task.user

    flash[:alert] = 'You can only edit, view, delete your own task'
    redirect_to tasks_path
  end
end
