class Task < ApplicationRecord
  belongs_to :task_list
  has_many :child_tasks, dependent: :destroy
  has_many :tasks, through: :child_tasks
  has_many :children, through: :child_tasks

  has_one_attached :quest_image

  validates :num_people, presence: true
  validates :point, presence: true

  # ステータス => 0:準備中 1:実行中 2:完了報告 3:やりなおし 4:完了
  enum status: {
    preparing: 0,
    in_progress: 1,
    reported_complete: 2,
    again: 3,
    completed: 4
  }

  def get_quest_image(width,height)
    unless quest_image.attached?
      file_path = Rails.root.join('app/assets/images/quest_image.png')
      quest_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    quest_image.variant(resize_to_fill: [width,height]).processed
  end

end
