class ChildTasksController < ApplicationController
  before_action :authenticate_user!

  def update
    task = current_user.tasks.find(params[:task_id])
    child_task = task.child_tasks

    mission_children = 0 # 初期人数
    child_task_params[:child_tasks].each do |ct| #フォームから送信された子タスクの情報を処理
      next if ct.to_i == 0 # 参加していない人はカウントさせない
      mission_children = mission_children + 1 # 参加している人がいれば+1する
    end

    if task.num_people < mission_children # タスクの人数より計算人数が多ければエラーを出す
      flash[:alert] = "人数が多すぎるよ"
      redirect_to request.referer
      return
    end

    child_task.destroy_all # 中間テーブルに書き込む前に一旦リセット(更新操作を行う前に、関連付けられたデータを一旦削除し、新しいデータを再度関連付けることで、データの整合性を保つ。)
    # フォームから受け取ったデータをループで書き込む
    child_task_params[:child_tasks].each do |ct|
      next if ct.to_i == 0 # 送られてきたデータが0の場合、処理しない
      child_task.create(child_id: ct) # 送られてきたデータを中間テーブルに書き込む
    end
    flash[:notice] ="エントリーしたよ！"
    redirect_to request.referer
  end

  private

  def child_task_params
    params.require(:task).permit(child_tasks: [])
  end

end
