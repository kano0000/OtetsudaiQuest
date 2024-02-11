class ChildTasksController < ApplicationController
  before_action :authenticate_user!

  def update
    task = current_user.tasks.find(params[:task_id])
    child_task = task.child_tasks


    mission_children = 0 # 初期人数
    child_task_params[:child_tasks].each do |ct|
      next if ct.to_i == 0 # 参加していない人はカウントさせない
      mission_children = mission_children + 1 # 参加している人がいれば+1する
    end

    if task.num_people < mission_children # タスクの人数より計算人数が多ければエラーを出す
      redirect_to request.referer, notice: "人数が多すぎるです。"
      return
    end

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
