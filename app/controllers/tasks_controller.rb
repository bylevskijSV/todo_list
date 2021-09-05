class TasksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
  end

  def new
  end

  def show
  end

  def creat
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
