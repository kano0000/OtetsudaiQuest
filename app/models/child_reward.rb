class ChildReward < ApplicationRecord
  belongs_to :reward
  belongs_to :child
  has_many :notifications, as: :notifiable, dependent: :destroy

  def create_notification(notifiable_id, user_id)
    Notification.create(user_id: user_id, notifiable_type: "ChildReward", notifiable_id: notifiable_id)
  end
  
  after_create do
    create_notification(id, Reward.find(reward_id).user_id)
  end

end
