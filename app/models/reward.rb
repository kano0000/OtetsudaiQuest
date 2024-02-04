class Reward < ApplicationRecord
  belongs_to :user
  has_many :child_rewards
  has_many :children, through: :child_rewards
  
  has_one_attached :gift_image
  
  
  def get_gift_image(width,height)
    unless gift_image.attached?
      file_path = Rails.root.join('app/assets/images/gift_image.png')
      gift_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')      
    end
    gift_image.variant(resize_to_limit: [width,height]).processed
  end
  
end
