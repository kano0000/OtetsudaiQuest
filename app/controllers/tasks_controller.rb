class TasksController < ApplicationController

  def index
    @tasks = current_user.tasks
  end

  def show
    @task = Task.find(params[:id])
    @children = current_user.children
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
      redirect_to task_path(@task)
    else
      render :show
    end
  end
  
  def admin_index
    @tasks  = current_user.tasks
  end
  
  def status_change
    @task = Task.find(params[:id])
    if @task.status == "preparing"
      @task.update(status: "in_progress")
    elsif @task.status == "in_progress"
      @task.update(status: "reported_complete")
    elsif @task.status == "reported_complete"
      if params[:check] == "OK"
       @task.update(status: "completed")
      else
        @task.update(status: "again")
      end
    elsif @task.status == "again"
      @task.update(status: "reported_complete")
    end
    #redirect_to in_progress_path(@task)
  end
  
  def thanks
  end

  private

  def task_params
    params.require(:task).permit(:task_list_id, :description, :point, :num_people, :start_at, :end_at, :quest_image)
  end

end
