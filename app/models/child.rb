class Child < ApplicationRecord
  belongs_to :user
  has_many :child_rewards
  has_many :rewards, through: :child_rewards
  has_many :child_tasks, dependent: :destroy
  has_many :tasks, through: :child_tasks


  has_one_attached :profile_image

  validates :name, presence: true, length: {in: 2..20}
  validates :birth_at, presence: true

  # レベル => 0:かけだし 1:ふつう 2:達人 3:伝説
  enum level: {
    beginner: 0,
    normal: 1,
    master: 2,
    legend: 3,
  }

  def level(month_clear)
    case month_clear.to_i
    when 0..5
      :beginner
    when 6..15
      :normal
    when 16..25
      :master
    else
      :legend
    end
  end

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

end
