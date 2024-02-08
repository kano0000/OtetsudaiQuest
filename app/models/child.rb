class Child < ApplicationRecord

  belongs_to :user
  has_many :child_rewards
  has_many :rewards, through: :child_rewards
  has_many :child_tasks, dependent: :destroy
  has_many :tasks, through: :child_tasks


  has_one_attached :profile_image

  validates :name, presence: true, length: {in: 2..20}

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image2.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width,height]).processed
  end

  def age
    if birth_at.present?
      now = Time.now.utc.to_date
      now.year - birth_at.year - ((now.month > birth_at.month || (now.month == birth_at.month && now.day >= birth_at.day)) ? 0 : 1)
    else
      nil
    end
  end

  def having_points

  end

end
