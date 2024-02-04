class TasksController < ApplicationController
  
  def index
    @tasks = current_user.tasks
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      flash[:notice] = "登録しました"
      redirect_to tasks_path
    else
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "更新しました。"
      redirect_to tasks_path
    else
      render :show
    end
  end
  
  private
  
  def task_params
    params.require(:task).permit(:task_list_id, :description, :point, :num_people, :start_at, :end_at, :quest_image)
  end
    
end
