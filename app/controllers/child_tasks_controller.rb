class ChildTasksController < ApplicationController
  
  def create
    task = Task.find(params[:task_id])
    child_task = current_user.child_tasks.new(child_task_params)
    child_task.task_id = task.id
    child.save
    redirect_to request.referer, notice: "子供がタスクに登録されました。"
  end
  
  
  def child_task_param
    params.require(:child_task).permit(:child_id)
  end
  
end
