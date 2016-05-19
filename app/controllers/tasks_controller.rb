class TasksController < ApplicationController
  def index
  	@tasks = Task.all
  	@task = Task.new
  end

  def create
  	task = Task.create task_params do |p|
      p.save
    end
      redirect_to :back
  end

  def new
  	    @task = Task.new
 	end

	def edit
    @task = Task.find params[:id]
	end

  def show
    @task = Task.find params[:id]
  end

  def update
    p = Task.find params[:id]
    p.update task_params
    redirect_to tasks_path
  end

  def destroy
    Task.find(params[:id]).delete
    redirect_to tasks_path
  end

  def unique
    @tasks = Task.all
    @task = Task.new
  end
 	  private

  def task_params
    params.require(:task).permit(:title, :status, :user_id, :project_id)
  end
end
