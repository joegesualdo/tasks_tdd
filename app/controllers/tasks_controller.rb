class TasksController < ApplicationController
  def index
    @task = Task.new

    @tasks = Task.all
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      redirect_to :back, notice: "Task created"
    else
      redirect_to :back, notice: "Task not created"
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to tasks_path, notice: "Your task has been successfully update"
    else
      redirect_to :back, notice: "There was an error updating your task"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to tasks_path, notice: "Task successfully deleted"
    else
      redirect_to :back, notice: "Task not deleted"
    end

  end
end
