class TaskListsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @task_lists = current_user.task_lists
    @task_list = TaskList.new
  end
  
  def create
    @task_list = TaskList.new(task_list_params)
    @task_list.user_id = current_user.id
    @task_lists = current_user.task_lists
    if @task_list.save
      flash[:notice] = "登録しました"
      redirect_to request.referer
    else
      render :index
    end
  end
  
  def edit
    @task_list = TaskList.find(params[:id])
  end
  
  def update
    @task_list = TaskList.find(params[:id])
    if @task_list.update(task_list_params)
      flash[:notice] = "更新しました。"
      redirect_to task_lists_path
    else
      render :index
    end
  end
  
  def destroy
    task_list = TaskList.find(params[:id])
    task_list.destroy
    redirect_to task_lists_path
  end
  
  private
  
  def task_list_params
    params.require(:task_list).permit(:name)
  end
  
end
