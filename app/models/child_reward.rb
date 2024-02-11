class ChildReward < ApplicationRecord
  belongs_to :reward
  belongs_to :child
  has_many :notifications, as: :notifiable, dependent: :destroy

  
  after_create do
    create_notification(user_id: current_user_id)
  end
  
end
