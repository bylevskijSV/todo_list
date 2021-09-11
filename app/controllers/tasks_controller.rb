class TasksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    if user_signed_in?
      @tasks = current_user.tasks.where.not(status: 3).order(:updated_at)

      @completed_tasks = current_user.tasks.where(status: 3).order(updated_at: :desc)
    else
      render :no_authenticate_index
    end
  end

  def no_authenticate_index
  end

  def new
    @task = Task.new

    @users = User.where.not(email: current_user.email)
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = assigned_task? ? Task.create(assigned_task_params) : current_user.tasks.create(task_params)

    if @task.errors.empty?
      flash[:notice] = 'Task was created successfully'
      redirect_to root_path
    else
      @users = User.where.not(email: current_user.email)
      render :edit
    end
  end

  def edit
    @task = Task.find(params[:id])
    @users = User.where.not(email: current_user.email)
  end

  def update
    @task = Task.find(params[:id])

    update_data = assigned_task? ? assigned_task_params : task_params

    if @task.update update_data
      flash[:notice] = 'Task was updated successfully'
      redirect_to task_path
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:alert] = 'Task was deleted successfully'
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

  def assigned_task_params
    user_id, parent_id = params[:task][:parent_id], current_user.id
    params.require(:task).permit(:title, :description, :status).merge(user_id: user_id, parent_id: parent_id)
  end

  def assigned_task?
    params[:task][:assigned_task].to_i == 1
  end
end
