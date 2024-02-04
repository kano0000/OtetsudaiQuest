class Task < ApplicationRecord
  belongs_to :task_list
  
  # 制作ステータス => 0:準備中 1:実行中 2:完了報告 3:やりなおし 4:完了
  enum making_status: {
    preparing: 0,
    in_progress: 1,
    reported_complete: 2,
    again: 3,
    completed: 4
  }

end
