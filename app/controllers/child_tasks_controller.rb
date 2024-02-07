class ChildTasksController < ApplicationController
  before_action :authenticate_user!

  def update
    child_task = current_user.tasks.find(params[:task_id]).child_tasks

    child_task.destroy_all # 中間テーブルに書き込む前に一旦リセット
    # フォームから受け取ったデータをループで書き込む
    child_task_params[:child_tasks].each do |ct|
      next if ct.to_i == 0 # 送られてきたデータが0の場合、処理しない
      child_task.create(child_id: ct) # 送られてきたデータを中間テーブルに書き込む
    end

    redirect_to request.referer, notice: "子供がタスクに登録されました。"
  end


  def child_task_params
    params.require(:task).permit(child_tasks: [])
  end

end
