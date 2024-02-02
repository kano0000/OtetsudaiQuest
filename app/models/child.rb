class Child < ApplicationRecord
  
  belongs_to :user
  
  has_one_attached :profile_image
  
  validates :name, presence: true, uniqueness: true, length: {in: 2..20}

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')      
    end
    profile_image.variant(resize_to_limit: [width,height]).processed
  end
  
end
