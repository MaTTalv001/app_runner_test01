class TasksController < ApplicationController
    def index
      @tasks = Task.all
    end
  
    def new
      @task = Task.new
    end
  
    def create
      @task = Task.new(task_params)
      if @task.save
        redirect_to tasks_path
      else
        render :new
      end
    end
  
    def destroy
      @task = Task.find(params[:id])
      @task.destroy
      redirect_to tasks_path, status: :see_other
    end
  
    private
  
    def task_params
      params.require(:task).permit(:title)
    end
  end
  