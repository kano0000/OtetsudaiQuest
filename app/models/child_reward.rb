class ChildReward < ApplicationRecord
  belongs_to :reward
  belongs_to :child
end
